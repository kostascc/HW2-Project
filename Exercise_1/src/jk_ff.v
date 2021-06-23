`timescale 10ps/10ps;
module jk_ff (
    input wire J, K, CLK,
    output reg Q, Qbar );

    always @(negedge CLK /*or posedge RST*/) 
    begin
        if ( J && K ) begin
            Q <= ~Q; 
            Qbar <= Q;
        end else if ( J ) begin
            Q = 1;
            Qbar = 0;
        end else if ( K ) begin
            Q = 0;
            Qbar = 1;
        end 
    end 

endmodule