`timescale 100ps/10ps;
module dFSM (
    output reg Y,
    input wire CLK, X, RST );

    reg[2:0] D;
    wire[2:0] Q;

    supply1 vdd;
    supply0 gnd;
    
    d_ff dff[2:0] (
        .D(D), 
        .CLK(CLK), 
        .Q(Q),
        .RST({ {2{RST}}, gnd }),
        .PRST({ {2{gnd}}, RST })
    );

    parameter rstState = 3'b001;

    initial begin
        D = rstState;
    end


    // D2' = ~D1 * ~D2 * X
    assign D[2] =   (RST)? 0 :
                    ~Q[1] && ~Q[2] && X;

    // D1' = D2 + (~X * ~D0) + (X * D0 * D1)
    assign D[1] =   (RST)? 0 :
                    (        Q[2]         ) ||
                    ( ~X && ~Q[0]         ) ||
                    (  X &&  Q[0] && Q[1] );

    // D0' = (X * D2) + (~X * ~D2) * ~(D1 * ~D0)
    assign D[0] =   (RST)? 1 :
                    (  X && Q[2]          ) ||
                    ( ~X && Q[2] && 
                         ~( Q[1] && ~Q[0] )
                    );

    // Y = ~D0 * X
    assign Y = ~Q[0] && X;  

    // Handle Async Reset
    always @(posedge RST) begin
        D = rstState;
    end

endmodule