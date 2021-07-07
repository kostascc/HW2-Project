/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

/**
 * This module is a 4-digit up counter
 * with a 7-segment output for each digit.
 * 
 * LED          :   7 Segment LED x 4 digits
 * LED_type_ctl :   LOW  = Common Cathode
 *                  HIGH = Common Anode
 * All signals are Active-HIGH!
 * EN, RST are Asynchronous.
 */
module d4BCDcounter7Seg(
    output wire [6:0] LED1, LED2, LED3, LED4,
    input wire EN, RST, LED_type_ctl
);

    wire[3:0] ABCD[3:0];

    d4BCDcounter u_cnt (
        .ABCD({ABCD}),
        .EN(EN),
        .RST(RST)
    );

    BCDto7Seg u_led[3:0] (
        .LED   ({ LED1[6:0],LED2[6:0],LED3[6:0],LED4[6:0] }),
        .ABCD  ({ABCD}),
        .LED_type_ctl(LED_type_ctl)
    );

endmodule