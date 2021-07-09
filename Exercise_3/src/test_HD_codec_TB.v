/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
`timescale 10ns/1ns
module test_HD_codec_TB;

    reg[11:0] IN;
    wire[11:0] OUT;
    reg clk;
    integer error_bit;
    test_HD_codec dut(.IN(IN), .OUT(OUT), .error_bit(error_bit));

    // Initialize
    initial begin
        clk = 0;
    end

    // Set input and error bit
    always @(posedge clk) begin
        IN = $urandom%(2**12-1);
        error_bit = $urandom%16;
    end

    // Check Output
    always @(negedge clk) begin
        if(IN != OUT) begin
            $display("Error");
        end
    end

    // Clock
    always begin
        #5 clk = ~clk;
    end

endmodule