`timescale 1ns/1ps

module tb_scan_tdc;
    reg clk = 0;
    reg latch = 0;
    reg scan_in = 0;
    reg [15:0] therm;
    wire scan_out;

    scan_dff_tdc #(.WIDTH(16)) dut (
        .clk(clk),
        .latch(latch),
        .scan_in(scan_in),
        .therm_in(therm),
        .scan_out(scan_out)
    );

    always #5 clk = ~clk;

    task pulse_clk;
        begin
            @(negedge clk);
            @(posedge clk);
        end
    endtask

    task read_scan;
        integer i;
        reg [15:0] captured;
        begin
            latch = 0;
            scan_in = 0;
            @(negedge clk);
            // Sample BEFORE each clock — first bit out is DFF[15]
            for (i = 0; i < 16; i = i + 1) begin
                captured[i] = scan_out;  // grab current Q[15-i]
                @(posedge clk);
                @(negedge clk);
            end
            // captured[0]=DFF[15], captured[15]=DFF[0], so display reversed
            $display("  Read back: %b (bit15 first out)", {captured[0],captured[1],captured[2],captured[3],captured[4],captured[5],captured[6],captured[7],captured[8],captured[9],captured[10],captured[11],captured[12],captured[13],captured[14],captured[15]});
        end
    endtask

    integer i;

    initial begin
        $display("=== Scan Chain TDC Test ===\n");

        therm = 16'b0;
        latch = 0;
        scan_in = 0;
        repeat(4) pulse_clk;

        // Test 1
        $display("Test 1: therm = 0000001111111111 (10 ones)");
        therm = 16'b0000001111111111;
        latch = 1; pulse_clk;  // Latch
        $display("  Stored:  0000001111111111");
        read_scan;

        // Test 2
        $display("\nTest 2: therm = 0000000000001111 (4 ones)");
        therm = 16'b0000000000001111;
        latch = 1; pulse_clk;
        $display("  Stored:  0000000000001111");
        read_scan;

        // Test 3
        $display("\nTest 3: therm = 0000000000000001 (1 one)");
        therm = 16'b0000000000000001;
        latch = 1; pulse_clk;
        $display("  Stored:  0000000000000001");
        read_scan;

        // Test 4
        $display("\nTest 4: therm = 0000000000000000 (0 ones)");
        therm = 16'b0000000000000000;
        latch = 1; pulse_clk;
        $display("  Stored:  0000000000000000");
        read_scan;

        // Test 5
        $display("\nTest 5: therm = 1111111111111111 (16 ones)");
        therm = 16'b1111111111111111;
        latch = 1; pulse_clk;
        $display("  Stored:  1111111111111111");
        read_scan;

        // Test 6: mixed pattern
        $display("\nTest 6: therm = 0011010101101001 (random)");
        therm = 16'b0011010101101001;
        latch = 1; pulse_clk;
        $display("  Stored:  0011010101101001");
        read_scan;

        $display("\n=== Done ===");
        $finish;
    end

    initial begin
        #10000;
        $display("TIMEOUT");
        $finish;
    end
endmodule
