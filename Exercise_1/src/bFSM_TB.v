/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
`timescale 10ns/1ns

module bFSM_TB;

    reg CLK, RST, X, expectedY;
    wire Y;
    integer i;
    reg [2:0] testVector[17:0];

    bFSM dut(.CLK(CLK), .RST(RST), .X(X), .Y(Y));
    
    // Initialize TB
    initial begin
        $readmemb("bFSM_TBVector",testVector);
        CLK = 0;
        i = 0;
        RST = 1; 
        X = 0;
    end

    // Update inputs and expected output
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

    // After the above well-defined inputs,
    // Check the response on async. inputs.
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
