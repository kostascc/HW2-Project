`timescale 1ns/10ps;
module dFSM (
    output reg Y,
    input wire CLK, X, RST );

    reg[2:0] D;
    wire[2:0] Q;

    reg intCLK, ENA;
    assign intCLK = CLK || ENA;
    
    d_ff dff [2:0] (
        .D(D), 
        .CLK(CLK), 
        .Q(Q)
        );

    parameter rstState = 3'b001;

    initial begin
        D = rstState;
    end

    // D2' = ~D1 * ~D2 * X
    assign D[2] =   ~Q[1] && ~Q[2] && X;

    // D1' = D2 + (~X * ~D0) + (X * D0 * D1)
    assign D[1] =   (        Q[2]         ) ||
                    ( ~X && ~Q[0]         ) ||
                    (  X &&  Q[0] && Q[1] );

    // D0' = (X * D2) + (~X * ~D2) * ~(D1 * ~D0)
    assign D[0] =   (  X && Q[2]          ) ||
                    ( ~X && Q[2] && 
                         ~( Q[1] && ~Q[0] )
                    );

    // Y = ~D0 * X
    assign Y = ~Q[0] && X;                

    // Handle Async Reset
    always @(posedge RST) begin
        D = rstState;
        ENA = 1;
    end

    always @(posedge ENA) begin
        ENA = 0;
    end

endmodule