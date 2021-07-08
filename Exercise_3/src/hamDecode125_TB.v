/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
`timescale 10ns/1ns
module hamDecode125_TB;

    wire[11:0] OUT;
    reg[16:0]  IN;
    reg clk;

    integer i;
    reg[28:0] testVector[23:0];
    reg[11:0] expectedOUT;

    hamDecode125 dut(
        .IN(IN),
        .OUT(OUT)
    );

    initial begin
        clk = 0;
        i = 0;
        expectedOUT = {12{1'b0}};
        $readmemb("hamEncoder125_TB_Vector", testVector);
        #5;
        for(i=0; i<24; i=i+1) begin
            #10;
            {expectedOUT,IN} = testVector[i];
        end
    end

    always @(negedge clk) begin
        if ({OUT[11:0]} != {expectedOUT[11:0]})
                $display("Wrong Output at i=%d!{%b, %b}", {i}, {OUT[11:0]}, {expectedOUT[11:0]});
    end

    always begin
        #5 clk = ~clk;
    end

endmodule