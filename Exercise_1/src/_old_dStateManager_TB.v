`timescale 1ns/100ps
module dStateManager_TB;

    reg clk, nxt, reset;

    wire[2:0] outCurrentState;
    reg[2:0] inNextState0, inNextState1, expectedCurrentState;
    reg inX;
    reg[31:0] i;
    reg[2:0] tmp;

    dStateManager dut(
        .NXT(nxt), 
        .RST(reset), 
        .sNext0(inNextState0), 
        .sNext1(inNextState1), 
        .X(inX),
        .sCurrent(outCurrentState),
        .CLK(clk)
        );

    reg [11:0] testVector[9:0];

initial
    begin
        $readmemb("dStateManager_TBVector",testVector);
        i = 0;
        clk = 1;
        reset = 0; 
        nxt = 0;
        inX = 0;
        inNextState0 = 3'bXXX;
        inNextState1 = 3'bXXX;
        expectedCurrentState = 3'bXXX;
    end

always@(negedge clk)
    begin
        {reset,nxt,inX,inNextState0,inNextState1,expectedCurrentState} = #4 testVector[i];
        $display("(%b,%b,%b,%b,%b,%b)", reset,nxt,inX,inNextState0,inNextState1,expectedCurrentState);
    end

// always@(posedge clk)
//     begin
//         {reset,nxt,inNextState,expectedCurrentState} = testVector[i];
//     end

always@(negedge clk)
    begin
        if(expectedCurrentState !== outCurrentState) begin
            $display("Wrong output for inputs (%b,%b,%b,%b,%b,%b), Actual: %b",reset,nxt,inX,inNextState0,inNextState1,expectedCurrentState,outCurrentState);
        end
        i = i + 1;
    end    

always
    begin
        clk <=1; #5;
        clk <=0; #5;
    end

endmodule
