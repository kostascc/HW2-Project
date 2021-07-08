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
    integer error_bit;
    test_HD_codec dut(.IN(IN), .OUT(OUT), .error_bit(error_bit));

    reg clk;

    initial begin
        clk = 0;
    end

    always @(posedge clk) begin
        IN = $urandom%(2**12-1);
        error_bit = $urandom%12;
    end

    always @(negedge clk) begin
        if(IN != OUT) begin
            $display("Error");
        end
    end

    always begin
        #5 clk = ~clk;
    end

endmodule