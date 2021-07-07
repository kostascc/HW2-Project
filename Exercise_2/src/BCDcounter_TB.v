`timescale 10ns/1ns;

module BCDcounter_TB;

    wire[3:0] ABCD;
    wire CARRY;
    reg EN, RST;

    reg[3:0] expectedOut;

    BCDcounter udp(
        .ABCD(ABCD),
        .RST(RST),
        .EN(EN),
        .CARRY(CARRY)
    );


    initial begin
        EN = 0;
        RST = 1;

        #9;
        RST = 0;
        EN = 1;

        #120;
        RST = 1;
        expectedOut = 4'b0000;
    end

    initial begin
        expectedOut = 4'b0000;

        #15;
        expectedOut = 4'b0001;

        #10; 
        expectedOut = 4'b0010;

        #10; 
        expectedOut = 4'b0011;

        #10; 
        expectedOut = 4'b0100;

        #10; 
        expectedOut = 4'b0101;

        #10; 
        expectedOut = 4'b0110;

        #10; 
        expectedOut = 4'b0111;

        #10; 
        expectedOut = 4'b1000;

        #10; 
        expectedOut = 4'b1001;

        #10;
        expectedOut = 4'b0000;

        #10;
        expectedOut = 4'b0001;

        #10; 
        expectedOut = 4'b0010;
    end

    always begin
        #5 EN = ~EN;
    end

endmodule