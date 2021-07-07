module bFSM(
    output reg Y,
    input CLK, RST, X);
    
    reg[2:0] currentState, nextState;
    parameter
        A = 3'b001,
        B = 3'b100,
        C = 3'b010,
        D = 3'b011,
        E = 3'b000;
    

    always @(posedge CLK or posedge RST)
    begin: STATE_MEMORY

        if(RST) currentState <= A ;
        else currentState <= nextState;

    end


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
    

    always @(currentState or X)
    begin: OUTPUT_LOGIC

        Y = (X) & (~currentState[2]);

    end

endmodule
