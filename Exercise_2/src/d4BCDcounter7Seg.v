/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

/**
 * This module is a 4-digit up counter
 * with a 7-segment output for each digit.
 * The output has the form of:
 *    { LED4, LED3, LED2, LED1 }
 *
 * LED(s)       :   7 Segment LED x 4 digits
 * LED_type_ctl :   LOW  = Common Cathode
 *                  HIGH = Common Anode
 * All signals are Active-HIGH!
 * EN, RST are Asynchronous.
 */
module d4BCDcounter7Seg(
    output wire [6:0] LED1, LED2, LED3, LED4,
    input wire EN, RST, CLK, LED_type_ctl
);

    wire[3:0] ABCD[3:0];

    //Clock Gating
    wire GCLK, nDQ;

    d_ff u_dff(
        .RST(RST),
        .CLK(CLK),
        .D(EN),
        .Q(nDQ),
        .Qn(Qn)
    );

    and u_a1( GCLK, nDQ, CLK );


    d4BCDcounter u_cnt (
        .ABCD1({ABCD[0]}),
        .ABCD2({ABCD[1]}),
        .ABCD3({ABCD[2]}),
        .ABCD4({ABCD[3]}),
        .EN(GCLK),
        .RST(RST)
    );

    BCDto7Seg u_led[3:0] (
        .LED   ({ LED1[6:0],LED2[6:0],LED3[6:0],LED4[6:0] }),
        .ABCD  ({ABCD}),
        .LED_type_ctl(LED_type_ctl)
    );

endmodule