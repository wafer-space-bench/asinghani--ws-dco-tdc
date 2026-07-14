// SPDX-License-Identifier: Apache-2.0
//
// Integrated DCO and multi-range TDC prototype.
//
// Input pad map:
//   0 DCO1 enable, 1 DCO2 enable, 2 DCO shift data, 3 DCO shift clock,
//   4 DCO shift latch, 5 TDC scan clock, 6 TDC scan latch,
//   7 TDC A, 8 TDC B, 9 TDC C, 10 TDC D.
//
// Output pad map:
//   0/1/2 DCO1, DCO1/2, DCO1/8; 3/4/5 DCO2, DCO2/2, DCO2/8;
//   6..11 scan data from TDC1..TDC6.

`timescale 1ns/1ps
`default_nettype none

module chip_core #(
    parameter NUM_INPUT_PADS  = 12,
    parameter NUM_BIDIR_PADS  = 40,
    parameter NUM_ANALOG_PADS = 2
)(
    `ifdef USE_POWER_PINS
    inout wire VDD,
    inout wire VSS,
    `endif
    input  wire clk,
    input  wire rst_n,
    input  wire [NUM_INPUT_PADS-1:0] input_in,
    output wire [NUM_INPUT_PADS-1:0] input_pu,
    output wire [NUM_INPUT_PADS-1:0] input_pd,
    input  wire [NUM_BIDIR_PADS-1:0] bidir_in,
    output wire [NUM_BIDIR_PADS-1:0] bidir_out,
    output wire [NUM_BIDIR_PADS-1:0] bidir_oe,
    output wire [NUM_BIDIR_PADS-1:0] bidir_cs,
    output wire [NUM_BIDIR_PADS-1:0] bidir_sl,
    output wire [NUM_BIDIR_PADS-1:0] bidir_ie,
    output wire [NUM_BIDIR_PADS-1:0] bidir_pu,
    output wire [NUM_BIDIR_PADS-1:0] bidir_pd,
    inout  wire [NUM_ANALOG_PADS-1:0] analog
);

    assign input_pu = '0;
    assign input_pd = '0;
    assign bidir_cs = '0;
    assign bidir_sl = '0;
    assign bidir_pu = '0;
    assign bidir_pd = '0;

    // Pads 0..11 are driven outputs. The rest stay input-capable/unused.
    wire [NUM_BIDIR_PADS-1:0] oe_mask;
    genvar bi;
    generate
        for (bi = 0; bi < NUM_BIDIR_PADS; bi = bi + 1) begin : g_pad_oe
            assign oe_mask[bi] = (bi < 12) ? 1'b1 : 1'b0;
        end
    endgenerate
    assign bidir_oe = oe_mask;
    assign bidir_ie = ~oe_mask;

    // Buffer every externally supplied control and measurement input.
    wire dco1_enable;
    wire dco2_enable;
    wire dco_shift_data;
    wire dco_shift_clk;
    wire dco_shift_latch;
    wire tdc_shift_clk;
    wire tdc_shift_latch;
    wire tdc_a;
    wire tdc_b;
    wire tdc_c;
    wire tdc_d;

    gf180mcu_fd_sc_mcu7t5v0__buf_4 ib0  (.I(input_in[0]),  .Z(dco1_enable));
    gf180mcu_fd_sc_mcu7t5v0__buf_4 ib1  (.I(input_in[1]),  .Z(dco2_enable));
    gf180mcu_fd_sc_mcu7t5v0__buf_4 ib2  (.I(input_in[2]),  .Z(dco_shift_data));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_4 ib3 (.I(input_in[3]),  .Z(dco_shift_clk));
    gf180mcu_fd_sc_mcu7t5v0__buf_4 ib4  (.I(input_in[4]),  .Z(dco_shift_latch));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_4 ib5 (.I(input_in[5]),  .Z(tdc_shift_clk));
    gf180mcu_fd_sc_mcu7t5v0__buf_4 ib6  (.I(input_in[6]),  .Z(tdc_shift_latch));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_4 ib7 (.I(input_in[7]),  .Z(tdc_a));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_4 ib8 (.I(input_in[8]),  .Z(tdc_b));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_4 ib9 (.I(input_in[9]),  .Z(tdc_c));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_4 ib10(.I(input_in[10]), .Z(tdc_d));

    // Serial tuning word. LATCH=0 shifts data in; LATCH=1 captures it.
    // dco1_word = {coarse[3:0], fine[3:0]}; same map for dco2_word.
    reg [15:0] dco_shift_word;
    reg [7:0] dco1_word;
    reg [7:0] dco2_word;
    always @(posedge dco_shift_clk or negedge rst_n) begin
        if (!rst_n) begin
            dco_shift_word <= 16'b0;
            dco1_word <= 8'b0;
            dco2_word <= 8'b0;
        end else if (dco_shift_latch) begin
            dco1_word <= dco_shift_word[7:0];
            dco2_word <= dco_shift_word[15:8];
        end else begin
            dco_shift_word <= {dco_shift_word[14:0], dco_shift_data};
        end
    end

    // Fast DCO: expected nominal region is roughly 100-300 MHz. Its four
    // coarse bits insert dlyd_4 cells; fine bits change parallel drive.
    wire dco1_raw;
    dco_fast u_dco1 (
        .enable(dco1_enable),
        .fine_code(dco1_word[3:0]),
        .coarse_code(dco1_word[7:4]),
        .out(dco1_raw)
    );

    // Slow DCO: one fixed dlyd_4 per inverter stage plus four optional
    // dlyd_4 cells produces a roughly 10-50 MHz experimental band.
    wire dco2_raw;
    dco_slow u_dco2 (
        .enable(dco2_enable),
        .fine_code(dco2_word[3:0]),
        .coarse_code(dco2_word[7:4]),
        .out(dco2_raw)
    );

    // Register-based dividers. Their reset follows each dedicated DCO enable.
    wire dco1_div2_raw;
    wire dco1_div4_raw;
    wire dco1_div8_raw;
    wire dco2_div2_raw;
    wire dco2_div4_raw;
    wire dco2_div8_raw;
    wire dco1_div_reset_n = rst_n & dco1_enable;
    wire dco2_div_reset_n = rst_n & dco2_enable;

    toggle_ff dco1_d2 (.clk(dco1_raw),      .reset_n(dco1_div_reset_n), .q(dco1_div2_raw));
    toggle_ff dco1_d4 (.clk(dco1_div2_raw), .reset_n(dco1_div_reset_n), .q(dco1_div4_raw));
    toggle_ff dco1_d8 (.clk(dco1_div4_raw), .reset_n(dco1_div_reset_n), .q(dco1_div8_raw));
    toggle_ff dco2_d2 (.clk(dco2_raw),      .reset_n(dco2_div_reset_n), .q(dco2_div2_raw));
    toggle_ff dco2_d4 (.clk(dco2_div2_raw), .reset_n(dco2_div_reset_n), .q(dco2_div4_raw));
    toggle_ff dco2_d8 (.clk(dco2_div4_raw), .reset_n(dco2_div_reset_n), .q(dco2_div8_raw));

    // Two large clock buffers are intentionally used before pad outputs.
    wire dco1_buf1;
    wire dco1_out;
    wire dco2_buf1;
    wire dco2_out;
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_16 dco1_bo0 (.I(dco1_raw), .Z(dco1_buf1));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_16 dco1_bo1 (.I(dco1_buf1), .Z(dco1_out));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_16 dco2_bo0 (.I(dco2_raw), .Z(dco2_buf1));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_16 dco2_bo1 (.I(dco2_buf1), .Z(dco2_out));

    // Six independently readable TDC scan chains share scan clock/latch.
    wire tdc1_scan_raw;
    wire tdc2_scan_raw;
    wire tdc3_scan_raw;
    wire tdc4_scan_raw;
    wire tdc5_scan_raw;
    wire tdc6_scan_raw;

    tdc_three_level tdc1 (.start(tdc_a),    .stop(tdc_b),    .rst_n(rst_n), .scan_clk(tdc_shift_clk), .scan_latch(tdc_shift_latch), .scan_in(1'b0), .scan_out(tdc1_scan_raw));
    tdc_three_level tdc2 (.start(tdc_b),    .stop(tdc_a),    .rst_n(rst_n), .scan_clk(tdc_shift_clk), .scan_latch(tdc_shift_latch), .scan_in(1'b0), .scan_out(tdc2_scan_raw));
    tdc_three_level tdc3 (.start(dco1_out), .stop(tdc_c),    .rst_n(rst_n), .scan_clk(tdc_shift_clk), .scan_latch(tdc_shift_latch), .scan_in(1'b0), .scan_out(tdc3_scan_raw));
    tdc_three_level tdc4 (.start(tdc_c),    .stop(dco1_out), .rst_n(rst_n), .scan_clk(tdc_shift_clk), .scan_latch(tdc_shift_latch), .scan_in(1'b0), .scan_out(tdc4_scan_raw));
    tdc_three_level tdc5 (.start(dco2_out), .stop(tdc_d),    .rst_n(rst_n), .scan_clk(tdc_shift_clk), .scan_latch(tdc_shift_latch), .scan_in(1'b0), .scan_out(tdc5_scan_raw));
    tdc_three_level tdc6 (.start(tdc_d),    .stop(dco2_out), .rst_n(rst_n), .scan_clk(tdc_shift_clk), .scan_latch(tdc_shift_latch), .scan_in(1'b0), .scan_out(tdc6_scan_raw));

    // Buffer all exported signals, including slow scan outputs.
    wire dco1_div2_out;
    wire dco1_div8_out;
    wire dco2_div2_out;
    wire dco2_div8_out;
    wire tdc1_scan_out;
    wire tdc2_scan_out;
    wire tdc3_scan_out;
    wire tdc4_scan_out;
    wire tdc5_scan_out;
    wire tdc6_scan_out;
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_16 dco1_b2 (.I(dco1_div2_raw), .Z(dco1_div2_out));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_16 dco1_b8 (.I(dco1_div8_raw), .Z(dco1_div8_out));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_16 dco2_b2 (.I(dco2_div2_raw), .Z(dco2_div2_out));
    gf180mcu_fd_sc_mcu7t5v0__clkbuf_16 dco2_b8 (.I(dco2_div8_raw), .Z(dco2_div8_out));
    gf180mcu_fd_sc_mcu7t5v0__buf_16 tdc_bo1 (.I(tdc1_scan_raw), .Z(tdc1_scan_out));
    gf180mcu_fd_sc_mcu7t5v0__buf_16 tdc_bo2 (.I(tdc2_scan_raw), .Z(tdc2_scan_out));
    gf180mcu_fd_sc_mcu7t5v0__buf_16 tdc_bo3 (.I(tdc3_scan_raw), .Z(tdc3_scan_out));
    gf180mcu_fd_sc_mcu7t5v0__buf_16 tdc_bo4 (.I(tdc4_scan_raw), .Z(tdc4_scan_out));
    gf180mcu_fd_sc_mcu7t5v0__buf_16 tdc_bo5 (.I(tdc5_scan_raw), .Z(tdc5_scan_out));
    gf180mcu_fd_sc_mcu7t5v0__buf_16 tdc_bo6 (.I(tdc6_scan_raw), .Z(tdc6_scan_out));

    reg [NUM_BIDIR_PADS-1:0] bout;
    always @(*) begin
        bout = '0;
        bout[0]  = dco1_out;
        bout[1]  = dco1_div2_out;
        bout[2]  = dco1_div8_out;
        bout[3]  = dco2_out;
        bout[4]  = dco2_div2_out;
        bout[5]  = dco2_div8_out;
        bout[6]  = tdc1_scan_out;
        bout[7]  = tdc2_scan_out;
        bout[8]  = tdc3_scan_out;
        bout[9]  = tdc4_scan_out;
        bout[10] = tdc5_scan_out;
        bout[11] = tdc6_scan_out;
    end
    assign bidir_out = bout;

    // Preserve otherwise-unused wrapper ports during synthesis.
    (* keep *) wire _keep_clk = clk;
    (* keep *) wire _keep_bidir = &{1'b0, bidir_in, analog};

endmodule

// -----------------------------------------------------------------------------
// Fast DCO: seven total inversions: NAND + six inverter stages. Coarse control
// inserts dlyd_4 before four tunable stages. Fine control changes drive strength.
// -----------------------------------------------------------------------------
(* keep_hierarchy *)
module dco_fast (
    input  wire enable,
    input  wire [3:0] fine_code,
    input  wire [3:0] coarse_code,
    output wire out
);
    wire ring0;
    wire [5:0] ring;
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__nand2_1 gate (.A1(enable), .A2(out), .ZN(ring0));

    dco_tunable_stage fs0 (.in(ring0),   .coarse(coarse_code[0]), .fine(fine_code), .out(ring[0]));
    dco_fixed_stage   fs1 (.in(ring[0]), .out(ring[1]));
    dco_tunable_stage fs2 (.in(ring[1]), .coarse(coarse_code[1]), .fine(fine_code), .out(ring[2]));
    dco_fixed_stage   fs3 (.in(ring[2]), .out(ring[3]));
    dco_tunable_stage fs4 (.in(ring[3]), .coarse(coarse_code[2]), .fine(fine_code), .out(ring[4]));
    dco_tunable_stage fs5 (.in(ring[4]), .coarse(coarse_code[3]), .fine(fine_code), .out(out));
endmodule

// -----------------------------------------------------------------------------
// Slow DCO: nine total inversions: NAND + eight stages. Every stage includes
// one fixed dlyd_4; four tunable stages add optional second dlyd_4 and drive trim.
// -----------------------------------------------------------------------------
(* keep_hierarchy *)
module dco_slow (
    input  wire enable,
    input  wire [3:0] fine_code,
    input  wire [3:0] coarse_code,
    output wire out
);
    wire ring0;
    wire [7:0] ring;
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__nand2_1 gate (.A1(enable), .A2(out), .ZN(ring0));

    dco_slow_tunable_stage ss0 (.in(ring0),   .coarse(coarse_code[0]), .fine(fine_code), .out(ring[0]));
    dco_slow_fixed_stage   ss1 (.in(ring[0]), .out(ring[1]));
    dco_slow_tunable_stage ss2 (.in(ring[1]), .coarse(coarse_code[1]), .fine(fine_code), .out(ring[2]));
    dco_slow_fixed_stage   ss3 (.in(ring[2]), .out(ring[3]));
    dco_slow_tunable_stage ss4 (.in(ring[3]), .coarse(coarse_code[2]), .fine(fine_code), .out(ring[4]));
    dco_slow_fixed_stage   ss5 (.in(ring[4]), .out(ring[5]));
    dco_slow_tunable_stage ss6 (.in(ring[5]), .coarse(coarse_code[3]), .fine(fine_code), .out(ring[6]));
    dco_slow_fixed_stage   ss7 (.in(ring[6]), .out(out));
endmodule

// One optional coarse dlyd_4, then a base tristate inverter plus four
// binary-weighted drive cells. More enabled fine bits means stronger drive.
(* keep_hierarchy *)
module dco_tunable_stage (
    input  wire in,
    input  wire coarse,
    input  wire [3:0] fine,
    output wire out
);
    wire delayed;
    wire stage_in;
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlyd_4 delay (.I(in), .Z(delayed));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__mux2_1 bypass (.I0(in), .I1(delayed), .S(coarse), .Z(stage_in));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__invz_1 base (.EN(1'b1),    .I(stage_in), .ZN(out));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__invz_1 drv1 (.EN(fine[0]), .I(stage_in), .ZN(out));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__invz_2 drv2 (.EN(fine[1]), .I(stage_in), .ZN(out));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__invz_4 drv4 (.EN(fine[2]), .I(stage_in), .ZN(out));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__invz_8 drv8 (.EN(fine[3]), .I(stage_in), .ZN(out));
endmodule

(* keep_hierarchy *)
module dco_fixed_stage (
    input wire in,
    output wire out
);
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__inv_1 inv (.I(in), .ZN(out));
endmodule

// Slow stages always include one dlyd_4. Coarse control can insert a second.
(* keep_hierarchy *)
module dco_slow_tunable_stage (
    input  wire in,
    input  wire coarse,
    input  wire [3:0] fine,
    output wire out
);
    wire delay0;
    wire delay1;
    wire stage_in;
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlyd_4 fixed_delay (.I(in), .Z(delay0));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlyd_4 extra_delay (.I(delay0), .Z(delay1));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__mux2_1 bypass (.I0(delay0), .I1(delay1), .S(coarse), .Z(stage_in));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__invz_1 base (.EN(1'b1),    .I(stage_in), .ZN(out));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__invz_1 drv1 (.EN(fine[0]), .I(stage_in), .ZN(out));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__invz_2 drv2 (.EN(fine[1]), .I(stage_in), .ZN(out));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__invz_4 drv4 (.EN(fine[2]), .I(stage_in), .ZN(out));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__invz_8 drv8 (.EN(fine[3]), .I(stage_in), .ZN(out));
endmodule

(* keep_hierarchy *)
module dco_slow_fixed_stage (
    input wire in,
    output wire out
);
    wire delayed;
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlyd_4 delay (.I(in), .Z(delayed));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__inv_1 inv (.I(delayed), .ZN(out));
endmodule

(* keep_hierarchy *)
module toggle_ff (
    input  wire clk,
    input  wire reset_n,
    output wire q
);
    wire d;
    assign d = ~q;
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 ff (.D(d), .RN(reset_n), .CLK(clk), .Q(q));
endmodule

// -----------------------------------------------------------------------------
// Three-level TDC. FINE is a Vernier pair. COARSE/XCOARSE are long delay lines.
// All 40 capture bits are copied into a regular-DFF mux scan chain.
// -----------------------------------------------------------------------------
(* keep_hierarchy *)
module tdc_three_level (
    input  wire start,
    input  wire stop,
    input  wire rst_n,
    input  wire scan_clk,
    input  wire scan_latch,
    input  wire scan_in,
    output wire scan_out
);
    wire [15:0] fine_start;
    wire [15:0] fine_stop;
    wire [15:0] fine_q;
    wire [15:0] coarse_tap;
    wire [15:0] coarse_q;
    wire [7:0] xcoarse_tap;
    wire [7:0] xcoarse_q;

    // FINE: two inv_1 stages per START tap versus two inv_4 stages per STOP tap.
    genvar fi;
    generate
        for (fi = 0; fi < 16; fi = fi + 1) begin : g_fine
            wire sm;
            wire pm;
            if (fi == 0) begin
                (* keep *) gf180mcu_fd_sc_mcu7t5v0__inv_1 si0 (.I(start), .ZN(sm));
                (* keep *) gf180mcu_fd_sc_mcu7t5v0__inv_1 si1 (.I(sm), .ZN(fine_start[fi]));
                (* keep *) gf180mcu_fd_sc_mcu7t5v0__inv_4 pi0 (.I(stop), .ZN(pm));
                (* keep *) gf180mcu_fd_sc_mcu7t5v0__inv_4 pi1 (.I(pm), .ZN(fine_stop[fi]));
            end else begin
                (* keep *) gf180mcu_fd_sc_mcu7t5v0__inv_1 si0 (.I(fine_start[fi-1]), .ZN(sm));
                (* keep *) gf180mcu_fd_sc_mcu7t5v0__inv_1 si1 (.I(sm), .ZN(fine_start[fi]));
                (* keep *) gf180mcu_fd_sc_mcu7t5v0__inv_4 pi0 (.I(fine_stop[fi-1]), .ZN(pm));
                (* keep *) gf180mcu_fd_sc_mcu7t5v0__inv_4 pi1 (.I(pm), .ZN(fine_stop[fi]));
            end
            (* keep *) gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 cap (.D(fine_stop[fi]), .RN(rst_n), .CLK(fine_start[fi]), .Q(fine_q[fi]));
        end
    endgenerate

    // COARSE: one dlyd_4 per tap; STOP is sampled directly.
    genvar ci;
    generate
        for (ci = 0; ci < 16; ci = ci + 1) begin : g_coarse
            if (ci == 0) begin
                (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlyd_4 d (.I(start), .Z(coarse_tap[ci]));
            end else begin
                (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlyd_4 d (.I(coarse_tap[ci-1]), .Z(coarse_tap[ci]));
            end
            (* keep *) gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 cap (.D(stop), .RN(rst_n), .CLK(coarse_tap[ci]), .Q(coarse_q[ci]));
        end
    endgenerate

    // XCOARSE: four dlyd_4 cells per tap.
    genvar xi;
    generate
        for (xi = 0; xi < 8; xi = xi + 1) begin : g_xcoarse
            wire d0;
            wire d1;
            wire d2;
            wire src;
            if (xi == 0) begin
                assign src = start;
            end else begin
                assign src = xcoarse_tap[xi-1];
            end
            (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlyd_4 dd0 (.I(src), .Z(d0));
            (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlyd_4 dd1 (.I(d0), .Z(d1));
            (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlyd_4 dd2 (.I(d1), .Z(d2));
            (* keep *) gf180mcu_fd_sc_mcu7t5v0__dlyd_4 dd3 (.I(d2), .Z(xcoarse_tap[xi]));
            (* keep *) gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 cap (.D(stop), .RN(rst_n), .CLK(xcoarse_tap[xi]), .Q(xcoarse_q[xi]));
        end
    endgenerate

    // Capture/shift chain order: FINE[0..15], COARSE[0..15], XCOARSE[0..7].
    // In shift mode, SCAN_IN=0 shifts zeros into FINE[0]; XCOARSE[7] exits.
    wire [40:0] scan_q;
    assign scan_q[0] = scan_in;
    genvar si;
    generate
        for (si = 0; si < 40; si = si + 1) begin : g_scan
            wire capture_bit;
            if (si < 16) begin
                assign capture_bit = fine_q[si];
            end else if (si < 32) begin
                assign capture_bit = coarse_q[si-16];
            end else begin
                assign capture_bit = xcoarse_q[si-32];
            end
            scan_capture_dff sc (
                .capture_bit(capture_bit),
                .shift_bit(scan_q[si]),
                .latch(scan_latch),
                .clk(scan_clk),
                .reset_n(rst_n),
                .q(scan_q[si+1])
            );
        end
    endgenerate
    assign scan_out = scan_q[40];
endmodule

// A regular DFF plus mux implements one scan-chain stage.
(* keep_hierarchy *)
module scan_capture_dff (
    input  wire capture_bit,
    input  wire shift_bit,
    input  wire latch,
    input  wire clk,
    input  wire reset_n,
    output wire q
);
    wire d;
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__mux2_1 mux (.I0(shift_bit), .I1(capture_bit), .S(latch), .Z(d));
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 ff (.D(d), .RN(reset_n), .CLK(clk), .Q(q));
endmodule

`default_nettype wire
