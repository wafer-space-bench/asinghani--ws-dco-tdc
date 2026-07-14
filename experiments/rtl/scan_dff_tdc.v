`timescale 1ns/1ps
`default_nettype none

module scan_dff_tdc #(
    parameter WIDTH = 16
)(
    input  wire clk,
    input  wire latch,      // 1=capture thermometer, 0=shift
    input  wire scan_in,     // serial in (tie to 0 for zeros)
    input  wire [WIDTH-1:0] therm_in,  // thermometer data from TDC taps
    output wire scan_out     // serial out (last bit)
);
    wire [WIDTH-1:0] mux_out;
    wire [WIDTH:0]   shift_chain;  // shift_chain[0]=scan_in, [i+1]=q[i]

    assign shift_chain[0] = scan_in;

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : g_scan
            // Mux: latch=1 → therm_in[i], latch=0 → previous Q (shift)
            assign mux_out[i] = latch ? therm_in[i] : shift_chain[i];

            // DFF
            dffrnq_1 dff (
                .D(mux_out[i]),
                .RN(1'b1),       // no reset (active low, tie high)
                .CLK(clk),
                .Q(shift_chain[i+1])
            );
        end
    endgenerate

    assign scan_out = shift_chain[WIDTH];
endmodule

module dffrnq_1(
    input  wire D,
    input  wire RN,
    input  wire CLK,
    output reg Q
);
    always @(posedge CLK or negedge RN) begin
        if (!RN) Q <= 1'b0;
        else     Q <= D;
    end
endmodule

`default_nettype wire
