`timescale 1ns/100ps

module dFSM_TB;

    reg clk;
    reg reset;
    reg in;
    reg tmp;

    wire out;
    reg expectedOut;
    reg [31:0] i;

    dFSM dut(.CLK(clk), .RST(reset), .X(in), .Y(out));
    reg [2:0] testVector[17:0];

initial
    begin
        $readmemb("bFSM_TBVector",testVector);
        i=0;
        reset=0;
        in=0;
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
    end

always@(negedge clk)
    begin
        #1;
        i=i+1;
        {reset,in,tmp}=testVector[i];
    end

always
    begin
        clk <=1; #5;
        clk <=0; #5;
    end

endmodule
