`timescale 1ns/1ps

module tb_chip_core;
    reg clk = 0;
    reg rst_n = 0;
    reg [11:0] input_in = 0;
    wire [11:0] input_pu;
    wire [11:0] input_pd;
    reg [39:0] bidir_in = 0;
    wire [39:0] bidir_out;
    wire [39:0] bidir_oe;
    wire [39:0] bidir_cs;
    wire [39:0] bidir_sl;
    wire [39:0] bidir_ie;
    wire [39:0] bidir_pu;
    wire [39:0] bidir_pd;
    wire [1:0] analog;

    integer dco1_edges = 0;
    integer dco2_edges = 0;
    integer dco1_div2_edges = 0;
    integer dco1_div8_edges = 0;
    integer dco2_div2_edges = 0;
    integer dco2_div8_edges = 0;
    integer i;
    reg [39:0] tdc1_scan_word;
    reg [39:0] tdc2_scan_word;

    chip_core dut (
        .clk(clk),
        .rst_n(rst_n),
        .input_in(input_in),
        .input_pu(input_pu),
        .input_pd(input_pd),
        .bidir_in(bidir_in),
        .bidir_out(bidir_out),
        .bidir_oe(bidir_oe),
        .bidir_cs(bidir_cs),
        .bidir_sl(bidir_sl),
        .bidir_ie(bidir_ie),
        .bidir_pu(bidir_pu),
        .bidir_pd(bidir_pd),
        .analog(analog)
    );

    always #5 clk = ~clk;
    always @(posedge bidir_out[0]) dco1_edges = dco1_edges + 1;
    always @(posedge bidir_out[1]) dco1_div2_edges = dco1_div2_edges + 1;
    always @(posedge bidir_out[2]) dco1_div8_edges = dco1_div8_edges + 1;
    always @(posedge bidir_out[3]) dco2_edges = dco2_edges + 1;
    always @(posedge bidir_out[4]) dco2_div2_edges = dco2_div2_edges + 1;
    always @(posedge bidir_out[5]) dco2_div8_edges = dco2_div8_edges + 1;

    task dco_clock;
        begin
            #2 input_in[3] = 1'b1;
            #2 input_in[3] = 1'b0;
        end
    endtask

    task tdc_clock;
        begin
            #2 input_in[5] = 1'b1;
            #2 input_in[5] = 1'b0;
        end
    endtask

    // Shift MSB first: after 16 clocks, word[15:0] is in the shift register.
    task load_dco_word(input [15:0] word);
        begin
            input_in[4] = 1'b0;
            for (i = 15; i >= 0; i = i - 1) begin
                input_in[2] = word[i];
                dco_clock;
            end
            input_in[4] = 1'b1;
            dco_clock;
            input_in[4] = 1'b0;
        end
    endtask

    task pulse_tdc_inputs;
        begin
            // A leads B by 10ns; C/D pulses exercise the other comparators.
            #10 input_in[7] = 1'b1;
            #4  input_in[7] = 1'b0;
            #6  input_in[8] = 1'b1;
            #4  input_in[8] = 1'b0;
            #10 input_in[9] = 1'b1;
            #4  input_in[9] = 1'b0;
            #10 input_in[10] = 1'b1;
            #4  input_in[10] = 1'b0;
        end
    endtask

    task scan_tdc1;
        begin
            input_in[6] = 1'b1;
            tdc_clock; // capture 40 thermometer bits
            input_in[6] = 1'b0;
            for (i = 0; i < 40; i = i + 1) begin
                // First shifted bit is TDC XCOARSE[7], last is FINE[0].
                tdc1_scan_word[i] = bidir_out[6];
                tdc_clock;
            end
        end
    endtask

    task scan_tdc2;
        begin
            input_in[6] = 1'b1;
            tdc_clock;
            input_in[6] = 1'b0;
            for (i = 0; i < 40; i = i + 1) begin
                tdc2_scan_word[i] = bidir_out[7];
                tdc_clock;
            end
        end
    endtask

    initial begin
        $display("=== Integrated DCO + TDC prototype behavioral test ===");
        input_in = '0;
        #30;
        rst_n = 1'b1;

        // DCO1: coarse=0000, fine=1111. DCO2: coarse=0000, fine=1111.
        // Dedicated enables remain low until both rings have settled disabled.
        load_dco_word(16'b0000_1111_0000_1111);
        #20;
        input_in[0] = 1'b1;
        input_in[1] = 1'b1;

        pulse_tdc_inputs;
        // dlyd_4 behavioral stubs have 3ns delay. Let all xcoarse chains settle.
        #250;

        scan_tdc1;
        scan_tdc2;

        #200;
        $display("DCO1 rising edges=%0d, /2=%0d, /8=%0d", dco1_edges, dco1_div2_edges, dco1_div8_edges);
        $display("DCO2 rising edges=%0d, /2=%0d, /8=%0d", dco2_edges, dco2_div2_edges, dco2_div8_edges);
        $display("TDC1 scan word (first-out at bit 0): %b", tdc1_scan_word);
        $display("TDC2 scan word (first-out at bit 0): %b", tdc2_scan_word);

        if (dco1_edges == 0 || dco2_edges == 0) begin
            $display("FAIL: one or both DCOs did not oscillate");
            $finish_and_return(1);
        end
        if (dco1_div2_edges == 0 || dco1_div8_edges == 0 || dco2_div2_edges == 0 || dco2_div8_edges == 0) begin
            $display("FAIL: one or more divider outputs did not toggle");
            $finish_and_return(1);
        end
        if (bidir_oe[11:0] !== 12'hfff) begin
            $display("FAIL: expected output-enable on bidir pads 0 through 11");
            $finish_and_return(1);
        end

        $display("PASS: DCOs, dividers, output map, and TDC scan capture exercised");
        $finish;
    end

    initial begin
        #5000;
        $display("FAIL: testbench timeout");
        $finish_and_return(1);
    end
endmodule
