`timescale 1ns/10ps;
module dStateManager(
    output wire[2:0] sCurrent,
    input  reg[2:0]  sNext0, sNext1,
    input  reg       NXT, X, RST, CLK
    );

    reg intENA;

    parameter startState = 3'b001;

    /**
     * Next State 0 D-FFs
    **/
    reg[2:0] nD0;
    wire[2:0] nQ0, nQ0bar;
    
    d_ff dNext0State [2:0] (
        .D(nD0), 
        .CLK(intENA), 
        .RST(nRST), 
        .Q(nQ0), 
        .Qbar(nQ0bar)
        );

    /**
     * Next State 1 D-FFs
    **/
    reg[2:0] nD1;
    wire[2:0] nQ1, nQ1bar;
    
    d_ff dNext1State [2:0] (
        .D(nD1), 
        .CLK(intENA), 
        .RST(nRST), 
        .Q(nQ1), 
        .Qbar(nQ1bar)
        );

    /**
     * Current State D-FFs
    **/
    reg[2:0] cD;
    wire[2:0] cQ, cQbar;

    d_ff dCurrentState [2:0] (
        .D(cD), 
        .CLK(intENA), 
        .RST(cRST), 
        .Q(cQ), 
        .Qbar(cQbar)
        );
    
    // Output
    assign sCurrent = cQ;

    // Initialize
    initial begin
        intENA = 0;
    end

    always @(posedge CLK or posedge RST)
    begin
        if(RST) begin
            // Reset 
            nD0 = startState;
            nD1 = startState;
            cD  = startState;

            intENA = 1;

        end else if (NXT) begin
            // Next States
            nD0 = sNext0;
            nD1 = sNext1;
            
            // Select current State
            cD = (X)? nQ1 : nQ0 ;

            intENA = 1;
        end
    end

    always @(posedge intENA) begin
        intENA <= 0;
    end
    

endmodule
