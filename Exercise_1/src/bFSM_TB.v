`timescale 1ns/100ps

module bFSM_TB;

    reg clk;
    reg reset;
    reg in;

    wire out;
    reg expectedOut;
    reg [31:0] i;

    bFSM dut(.CLK(clk), .RST(reset), .X(in), .Y(out));
    reg [2:0] testVector[17:0];

initial
    begin
        $readmemb("bFSM_TBVector",testVector);
        i=0;
        reset=1; in=0;
    end

always@(posedge clk)
    begin
        {reset,in,expectedOut}=testVector[i];#10;
        $display(reset,in,expectedOut);
    end

always@(negedge clk)
    begin
        if(expectedOut !== out) begin
            $display("Wrong output for inputs %b, %b!=%b",{reset,in},expectedOut,out);
        end
        i=i+1;
    end

always
    begin
        clk <=1; #5;
        clk <=0; #5;
    end

endmodule
