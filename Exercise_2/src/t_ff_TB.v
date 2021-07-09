/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
 
`timescale 10ns/1ns
module t_ff_TB;

    reg T, CLK, INIT, tmp;

    wire Q, Qbar;
    reg expectedOut, rst;
    integer i;

    t_ff dut( 
        .Q(Q), 
        .Qn(Qbar), 
        .T(T), 
        .CLK(CLK), 
        .RST(INIT) 
    ); 
    reg [2:0] testVector[20:0];

    // Initialize
    initial begin
        $readmemb("t_ff_TBVector",testVector);
        i = 0;
        INIT = 0;
        CLK = 0;
        T = 0;
    end

    // Set Input, expected output
    always@(posedge CLK) begin
        {INIT,T,expectedOut}=testVector[i];#10;
    end

    // Check the output
    always@(posedge CLK) begin
        if(expectedOut !== Q) begin
            $display("Wrong output for inputs %b, %b!=%b",{T},expectedOut,Q);
        end
        #1 i = i + 1;
    end

    // Clock
    always begin
        #5; CLK = ~CLK;
    end

endmodule

