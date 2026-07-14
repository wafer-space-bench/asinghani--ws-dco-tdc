// SPDX-License-Identifier: Apache-2.0
//
// Simulation stubs for GF180MCU standard cells.
// Behavioral models for Icarus — includes #1 delay to break
// zero-delay combinational loops in ring oscillators.

`default_nettype none

// --- Inverters ---
module gf180mcu_fd_sc_mcu7t5v0__inv_1 (input I, output ZN);
    assign #1 ZN = ~I;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__inv_4 (input I, output ZN);
    assign #1 ZN = ~I;
endmodule

// --- Tristate inverters ---
module gf180mcu_fd_sc_mcu7t5v0__invz_1 (input EN, input I, output ZN);
    assign #1 ZN = (EN) ? ~I : 1'bz;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__invz_2 (input EN, input I, output ZN);
    assign #1 ZN = (EN) ? ~I : 1'bz;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__invz_4 (input EN, input I, output ZN);
    assign #1 ZN = (EN) ? ~I : 1'bz;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__invz_8 (input EN, input I, output ZN);
    assign #1 ZN = (EN) ? ~I : 1'bz;
endmodule

// --- Delay cell ---
module gf180mcu_fd_sc_mcu7t5v0__dlyd_4 (input I, output Z);
    assign #3 Z = I;
endmodule

// --- NAND gate ---
module gf180mcu_fd_sc_mcu7t5v0__nand2_1 (input A1, input A2, output ZN);
    assign #1 ZN = ~(A1 & A2);
endmodule

// --- DFF with active-low reset ---
module gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 (input D, input RN, input CLK, output reg Q);
    initial Q = 1'b0;
    always @(posedge CLK or negedge RN) begin
        if (!RN) Q <= 1'b0;
        else     Q <= D;
    end
endmodule

// --- Mux 2:1 ---
module gf180mcu_fd_sc_mcu7t5v0__mux2_1 (input I0, input I1, input S, output Z);
    assign #1 Z = (S) ? I1 : I0;
endmodule

// --- Buffers ---
module gf180mcu_fd_sc_mcu7t5v0__buf_4 (input I, output Z);
    assign #1 Z = I;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__buf_16 (input I, output Z);
    assign #1 Z = I;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__clkbuf_4 (input I, output Z);
    assign #1 Z = I;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__clkbuf_16 (input I, output Z);
    assign #1 Z = I;
endmodule

// --- Tie cells ---
module gf180mcu_fd_sc_mcu7t5v0__tieh (output Z);
    assign Z = 1'b1;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__tiel (output ZN);
    assign ZN = 1'b0;
endmodule

`default_nettype wire
