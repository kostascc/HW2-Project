`timescale 1ns/100ps
module d_ff_TB;

    reg expectedOut;
    reg [31:0] i;
    reg [2:0] testVector[20:0];

    reg d, clk;
    wire q, qbar;

    d_ff dut(.Q(q), .Qbar(qbar), .D(d), .CLK(clk)); 

initial
    begin
        $readmemb("d_ff_TBVector", testVector);
        i = 0;
        d = 0;
    end

always @(posedge clk)
    begin
        {d, expectedOut} = testVector[i];
        // $display(reset, d, expectedOut);
        
    end

always @(negedge clk)
    begin
        i = i + 1;
        if(expectedOut !== q) begin
            $display("Wrong output for inputs %b, %b!=%b",{d}, expectedOut, q);
        end
        
    end

always
    begin
        clk <= 1; #5;
        clk <= 0; #5;
    end

endmodule
