/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

`timescale 10ns/1ns 

module d_ff_TB;

wire Q, Qn;
reg D, CLK, RST;

d_ff dut(Q, Qn, D, CLK, RST);

reg expectedOut;

initial begin
    CLK = 1'b0;
    expectedOut = 0'b0;
    D = 1'b0;
end

always begin
    #5;
    CLK= ~CLK;
end

initial begin
    RST = 1'b1;
    
    #2;
    RST = 1'b0;

    #2;
    D = 1'b0;

    #10;
    D = 1'b1;
    expectedOut = D;

    #10;
    D = 1'b0;
    expectedOut = D;

    #20;
    D = 1'b1;
    expectedOut = D;

    #20;
    RST = 1'b1;
    expectedOut = 1'b0;

    #10;
    RST = 1'b0;
    expectedOut = 1'b1;
    
end

endmodule