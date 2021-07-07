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
module 4dBCDcounter7Seg(
    output wire[6:0] LED[3:0],
    input EN, RST, LED_type_ctl
);

    wire[3:0] ABCD[3:0];

    4dBCDcounter u_cnt (
        .ABCD({ ABCD[3:0][3:0] }),
        .EN  ( EN  ),
        .RST ( RST )
    );

    BCDto7Seg[3:0] u_led (
        .LED   ({  LED[3:0][6:0] }),
        .ABCD  ({ ABCD[3:0][3:0] }),
        .LED_type_ctl(LED_type_ctl), 
    );

endmodule