/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
`timescale 10ns/1ns

module dFSM_TB;

    reg CLK, RST, X, expectedY;
    wire Y;
    integer i;

    dFSM dut(.CLK(CLK), .RST(RST), .X(X), .Y(Y));
    reg [2:0] testVector[17:0];

    // Initialize
    initial begin
        $readmemb("bFSM_TBVector",testVector);
        CLK = 0;
        i = 0;
        RST = 1; 
        X = 0;
    end

    // Set Inputs
    always@(posedge CLK) begin
        if (i <= 18) begin
            {RST,X,expectedY} = testVector[i];
        end
    end

    // Check Output
    always@(negedge CLK)
    begin
        if(i <= 18) begin
            if(expectedY !== Y) begin
                $display("Wrong input for outputs %b, %b!=%b",{RST,X},expectedY,Y);
            end
            if(i <= 18) begin
                i = i+1;
            end
        end
    end

    // Asynchronous test
    initial begin
        #165;   // Wait for the pre-determined vectors to end
        i = 100;// Stop assigning pre-determined values

        #3;
        RST <= 1;
        X <= 0;
        expectedY <= 0;

        #5;
        RST <= 0;
        expectedY <= 0;

        #10;
        X <= 1;
        expectedY <= 1;

        #2;
        X <= 0;
        expectedY <= 0;
    end

    // Clock
    always begin
        #5 CLK <= ~CLK;
    end

endmodule