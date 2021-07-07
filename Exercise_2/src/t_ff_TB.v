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
    reg [31:0] i;

    t_ff dut( 
        .Q(Q), 
        .Qn(Qbar), 
        .T(T), 
        .CLK(CLK), 
        .RST(INIT) 
    ); 
    reg [2:0] testVector[20:0];

initial
    begin
        $readmemb("t_ff_TBVector",testVector);
        i = 0;
        INIT = 0;
        CLK = 0;
        T = 0;
    end

always@(posedge CLK)
    begin
        {INIT,T,expectedOut}=testVector[i];#10;
    end

always@(posedge CLK)
    begin
        if(expectedOut !== Q) begin
            $display("Wrong output for inputs %b, %b!=%b",{T},expectedOut,Q);
        end
        #1 i = i + 1;
    end

always
    begin
        CLK <= 1; #5;
        CLK <= 0; #5;
    end

endmodule

