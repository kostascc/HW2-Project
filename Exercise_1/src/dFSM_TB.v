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
    reg [2:0] testVector[23:0];

initial
    begin
        $readmemb("bFSM_TBVector",testVector);
        i=-1;
        reset=1;
        in=0;
        clk = 0;
        expectedOut = 0;
    end

always@(negedge clk)
    begin
        #4
        {reset,in,expectedOut}=testVector[i];
        // $display(reset,in,expectedOut);
    end

always@(negedge clk)
    begin
        #3
        if(expectedOut !== out) begin
            $display("Wrong output at %d for inputs %b, %b!=%b",i,{reset,in},expectedOut,out);
        end
        i=i+1;
    end

// always@(negedge clk)
//     begin
//         #1;
//         {reset,in,tmp}=testVector[i];#9;
//     end

always
    begin
        clk <=1; #5;
        clk <=0; #5;
    end

endmodule
