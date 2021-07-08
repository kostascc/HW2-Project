/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
module jkFSM (
    output reg Y,
    input wire CLK, X, RST 
);

    reg[2:0] D, J, K;
    wire[2:0] Q;

    supply0 gnd;
    
    assign J =  D;
    assign K = ~D;

    jk_ff jkff[2:0] (
        .J(J),
        .K(K),
        .CLK(CLK), 
        .Q(Q),
        .RST({ {2{RST}}, gnd }),
        .PRST({ {2{gnd}}, RST })
    );

    parameter rstState = 3'b001;

    initial begin
        D = rstState;
    end

    assign D[2] =   ( ~Q[1] && ~Q[2] && X );

    assign D[1] =   ( ~X && ~Q[0] && ~Q[2]           ) ||
                    (       ~Q[0] && ~Q[1] &&  Q[2]  ) ||
                    (  X &&  Q[0] &&  Q[1] && ~Q[2]  );

    assign D[0] =   ( ~X && ~Q[1] && ~Q[2] ) ||
                    ( ~X &&  Q[0] && ~Q[2] ) ||
                    (  X && ~Q[0] && ~Q[1] && Q[2] );

    assign Y = ~Q[2] && X;  

endmodule