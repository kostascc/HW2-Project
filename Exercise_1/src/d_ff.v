/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

/**
 * D-FF
 * Positive edge triggered.
 * RST, PRST: Active-HIGH.
 * 
 * RST:  Resets the D-FF to Q=0.
 * PRST: Sets the D-FF to the preset Q=1.
 */
module d_ff (
    output reg Q, Qn,
    input wire D, CLK, RST, PRST
);

    assign Qn = ~Q;
    
    always @(posedge CLK or posedge RST or posedge PRST) 
    begin
        if( RST ) begin
            Q  <= 0;
        end else if ( PRST ) begin 
            Q  <= 1;
        end else begin
            Q  <= D; 
        end
    end 

endmodule