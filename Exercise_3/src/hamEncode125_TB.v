/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
 `timescale 10ns/1ns
module hamEncode125_TB;

    wire[16:0] OUT;
    reg[11:0]  IN;
    reg clk;
    integer i;
    reg[28:0] testVector[23:0];
    reg[16:0] expectedOUT;

    hamEncode125 dut(
        .IN(IN),
        .OUT(OUT)
    );

    // Initialize and loop through predifined Inputs
    initial begin
        clk = 0;
        i = 0;
        expectedOUT = {17{1'b0}};
        $readmemb("hamEncoder125_TB_Vector", testVector);
        for(i=0; i<24; i=i+1) begin
            #10; {IN,expectedOUT} = testVector[i];
        end
    end

    // Check output
    always @(negedge clk) begin
        if ({OUT[11:0]} != {expectedOUT[11:0]})
                $display("Wrong Output at i=%d!{%b, %b}", {i}, {OUT[11:0]}, {expectedOUT[11:0]});
    end

    // Clock
    always begin
        #5 clk = ~clk;
    end
endmodule