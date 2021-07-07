`timescale 10ns/1ns;

module BDCto7Seg_TB;

    wire[6:0] LED;
    reg[3:0] ABCD;
    reg LED_type_ctl;

    reg[6:0] expectedLED;

    BCDto7Seg dut(
        .LED(LED),
        .ABCD(ABCD),
        .LED_type_ctl(LED_type_ctl)
    );

    initial begin
        // Common Cathode
        LED_type_ctl = 1'b0;

        ABCD = 4'b_0000;//0
        expectedLED = 7'b_1111110;

        #1;
        ABCD = 4'b_0001;//1
        expectedLED = 7'b_0110000;

        #1;
        ABCD = 4'b_0010;//2
        expectedLED = 7'b_1101101;

        #1;
        ABCD = 4'b_0011;//3
        expectedLED = 7'b_1111001;

        #1;
        ABCD = 4'b_0100;//4
        expectedLED = 7'b_0110011;

        #1;
        ABCD = 4'b_0101;//5
        expectedLED = 7'b_1011011;

        #1;
        ABCD = 4'b_0110;//6
        expectedLED = 7'b_1011111;

        #1;
        ABCD = 4'b_0111;//7
        expectedLED = 7'b_1110000;

        #1;
        ABCD = 4'b_1000;//8
        expectedLED = 7'b_11111111;

        #1;
        ABCD = 4'b_1001;//9
        expectedLED = 7'b_11111011;


        // Common Anode
        LED_type_ctl = 1'b1;

        ABCD = 4'b_0000;//0
        expectedLED = ~(7'b_1111110);

        #1;
        ABCD = 4'b_0001;//1
        expectedLED = ~(7'b_0110000);

        #1;
        ABCD = 4'b_0010;//2
        expectedLED = ~(7'b_1101101);

        #1;
        ABCD = 4'b_0011;//3
        expectedLED = ~(7'b_1111001);

        #1;
        ABCD = 4'b_0100;//4
        expectedLED = ~(7'b_0110011);

        #1;
        ABCD = 4'b_0101;//5
        expectedLED = ~(7'b_1011011);

        #1;
        ABCD = 4'b_0110;//6
        expectedLED = ~(7'b_1011111);

        #1;
        ABCD = 4'b_0111;//7
        expectedLED = ~(7'b_1110000);

        #1;
        ABCD = 4'b_1000;//8
        expectedLED = ~(7'b_11111111);

        #1;
        ABCD = 4'b_1001;//9
        expectedLED = ~(7'b_11111011);

    end


endmodule