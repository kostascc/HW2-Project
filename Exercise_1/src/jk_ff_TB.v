`timescale 1ns/100ps
module jk_ff_TB;

    reg expectedOut;
    reg [31:0] i;
    reg [2:0] testVector[7:0];

    reg j, k, clk, reset, tmp;
    wire q, qbar;

    jk_ff dut(.Q(q), .Qbar(qbar), .J(j), .K(k), .CLK(clk)); 

initial
    begin
        $readmemb("jk_ff_TBVector", testVector);
        i = 0; 
        j = 0;
        k = 0;
    end

always @(posedge clk)
    begin
        {j, k, tmp} = testVector[i];
        // $display(reset, d, expectedOut);
        
    end

always @(negedge clk)
    begin
        {j, k, expectedOut} = testVector[i];
        #4
        i = i + 1;
        if(expectedOut !== q) begin
            $display("Wrong output for inputs %b, %b!=%b",{j, k}, expectedOut, q);
        end
        
    end

always
    begin
        clk <= 1; #5;
        clk <= 0; #5;
    end

endmodule
