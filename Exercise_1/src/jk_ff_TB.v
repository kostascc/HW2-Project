/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
 `timescale 10ns/1ns
module jk_ff_TB;

    reg expectedQ;

    reg J, K, CLK, PRST, RST;
    wire Q, Qn;

    jk_ff dut(
        .Q(Q), 
        .Qn(Qn), 
        .J(J), 
        .K(K),
        .CLK(CLK), 
        .PRST(PRST), 
        .RST(RST)
    ); 

    initial begin
        J = 0;
        K = 0;
        CLK = 0;
        RST = 1;
        PRST = 0;
        expectedQ = 0;
    end

    initial begin
        #4;
        RST = 0;

        #10;
        J <= 1;
        expectedQ <= #1 1;

        #10;
        J <= 0;
        K <= 1;
        expectedQ <= #1 0;

        #10;
        J <= 1;
        K <= 1;
        expectedQ <= #1 ~expectedQ;

        #10;
        J <= 1;
        K <= 1;
        expectedQ <= #1 ~expectedQ;

        #10;
        J <= 0;
        K <= 0;

        #10;
        RST <= 1;
        expectedQ <= 0;

        #10;
        RST <= 0;
        PRST <= 1;
        expectedQ <= 1;

        #10;
        RST <= 1;
        PRST <= 1;
        expectedQ <= 0;

        #10;
        J <= 1;
        K <= 1;

        #10;
        RST <= 0;
        PRST <= 0;
        J <= 0;
        K <= 1;
        expectedQ <= 0;

        #10;
        K <= 0;
    end

    always begin
        #5 CLK <= ~CLK;
    end

endmodule