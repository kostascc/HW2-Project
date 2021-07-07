`timescale 10ns/1ns
module d_ff_TB;

    reg expectedQ;

    reg D, CLK, PRST, RST;
    wire Q, Qn;

    d_ff dut(.Q(Q), .Qn(Qn), .D(D), .CLK(CLK), .PRST(PRST), .RST(RST)); 

    initial begin
        D = 0;
        CLK = 0;
        RST = 1;
        PRST = 0;
        expectedQ = 0;
    end

    initial begin
        #4;
        RST <= 0;

        #10;
        D <= 1;
        expectedQ <= #1 1;

        #10;
        D <= 0;
        expectedQ <= #1 0;

        #4;
        PRST <= 1;
        expectedQ <= 1;

        #4;
        RST <= 1;
        expectedQ <= 0;

        #2;
        RST <= 0;
        expectedQ <= #1 1;

        #10;
        PRST <= 0;
        expectedQ <= #1 0;

        #10;
        D <= 1;
        expectedQ <= #1 1;

    end
    always begin
        #5 CLK <= ~CLK;
    end

endmodule
