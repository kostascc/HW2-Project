/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
module bFSM(
    output reg Y,
    input CLK, RST, X
);
    
    // States
    localparam
        A = 3'b001,
        B = 3'b100,
        C = 3'b010,
        D = 3'b011,
        E = 3'b000;
    reg[2:0] currentState, nextState;

    // Current state control
    always @(posedge CLK or posedge RST)
    begin: STATE_MEMORY
        if (RST) begin
            currentState <= A ;
        end else begin
            currentState <= nextState;
        end
    end

    // Next state control
    always @(currentState or X)
    begin: NEXT_STATE_LOGIC
        case(currentState)
            E: nextState = (X)? B : D;
            A: nextState = (X)? B : A;
            C: nextState = (X)? E : C;
            D: nextState = (X)? C : A;
            B: nextState = (X)? D : C;
            default: nextState = A;
        endcase
    end
    
    // Output (Y) control
    always @(currentState or X)
    begin: OUTPUT_LOGIC
        Y = (X) & (1'b1-currentState[2]);
    end

endmodule
