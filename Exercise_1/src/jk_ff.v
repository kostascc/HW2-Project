/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

/**
 * JK-FF
 * Positive edge triggered.
 * RST, PRST: Active-HIGH.
 * 
 * RST:  Resets the JK-FF to Q=0.
 * PRST: Sets the JK-FF to the preset Q=1.
 */
module jk_ff (
    input wire J, K, CLK,
    output reg Q, Qn, RST, PRST );

    assign Qn = ~Q;

    always @(posedge CLK or posedge RST or posedge PRST) 
    begin
        if (RST) begin
            Q <= 0;
        end else if (PRST) begin
            Q <= 1;
        end else if ( J & K ) begin
            Q <= ~Q; 
        end else if ( J ) begin
            Q <= 1;
        end else if ( K ) begin
            Q <= 0;
        end else begin
            Q <= 0;
        end
    end 

endmodule