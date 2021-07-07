`timescale 100ns/100ns

module d4BCDcounter7Seg_TB;

    wire[6:0]     LED1, LED2, LED3, LED4;
    reg       EN, RST, CLK, LED_type_ctl;

    d4BCDcounter7Seg dut(
        .LED1(LED1),
        .LED2(LED2),
        .LED3(LED3),
        .LED4(LED4),
        .EN(EN),
        .RST(RST),
        .CLK(CLK),
        .LED_type_ctl(LED_type_ctl)
    );

    wire[6:0] LEDout[3:0];  // LED output vector
    integer      out[3:0];  // Decimal output vector
    integer i;
    reg[6:0] normalizedLEDOut;

    assign {
        LEDout[3][6:0],LEDout[2][6:0],LEDout[1][6:0],LEDout[0][6:0]
        } = {
        LED4[6:0],LED3[6:0],LED2[6:0],LED1[6:0]
    };

    initial begin
        LED_type_ctl = 1'b0;
        EN = 1'b0;
        RST = 1'b1;
        CLK = 1'b0;
    end

    initial begin
        #4;
        RST = 1'b0;

        #20;
        EN = 1'b1;
    end

    // Convert 7-Seg. to Decimal
    always @(LED1 or LED2 or LED3 or LED4) begin
        for(i=0; i<4; i=i+1) begin
            normalizedLEDOut = (LED_type_ctl==1'b1)? ~({LEDout[i][6:0]}) : ({LEDout[i][6:0]});
            case( normalizedLEDOut )
                7'b_1111110:    out[i] = 0;
                7'b_0110000:    out[i] = 1;
                7'b_1101101:    out[i] = 2;
                7'b_1111001:    out[i] = 3;
                7'b_0110011:    out[i] = 4;
                7'b_1011011:    out[i] = 5;
                7'b_1011111:    out[i] = 6;
                7'b_1110000:    out[i] = 7;
                7'b_1111111:    out[i] = 8;
                7'b_1111011:    out[i] = 9;
            endcase
        end
    end

    always begin
        #5 CLK = ~CLK;
    end

    

endmodule