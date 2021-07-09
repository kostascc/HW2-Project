/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
module dFSM (
    output reg Y,
    input wire CLK, X, RST 
);

    reg[2:0] D;
    wire[2:0] Q;

    supply0 gnd;
    
    // Three D-FFs
    d_ff dff[2:0] (
        .D(D), 
        .CLK(CLK), 
        .Q(Q),
        .RST({ {2{RST}}, gnd }),
        .PRST({ {2{gnd}}, RST })
    );

    localparam defState = 3'b001;

    initial begin
        D = defState;
    end

    // Next States
    assign D[2] =   ( ~Q[1] && ~Q[2] && X );

    assign D[1] =   ( ~X && ~Q[0] && ~Q[2]           ) ||
                    (       ~Q[0] && ~Q[1] &&  Q[2]  ) ||
                    (  X &&  Q[0] &&  Q[1] && ~Q[2]  );

    assign D[0] =   ( ~X && ~Q[1] && ~Q[2] ) ||
                    ( ~X &&  Q[0] && ~Q[2] ) ||
                    (  X && ~Q[0] && ~Q[1] && Q[2] );

    // Output
    assign Y = ~Q[2] && X;  

endmodule