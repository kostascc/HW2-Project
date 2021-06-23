/*
* D Flip-Flop
* (Source: technobyte.org)
*/
`timescale 10ps/10ps;
module d_ff (
    input wire D, CLK, /*RST,*/
    output reg Q, Qbar );

    always @(posedge CLK /*or posedge RST*/) 
    begin
        // if( RST == 1 ) begin
        //     #1; // Delay
        //     Q <= 0;
        //     Qbar <= 1;
        // end else begin 
        Q <= D; 
        Qbar <= ~D; 
        // end
    end 

endmodule