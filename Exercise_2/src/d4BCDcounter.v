/**
 * This is a 4-digit BCD counter,
 * with four BCD outputs.
 * All signals are active-HIGH.
 * RST is asynchronous.
 *
 * Output order {MSB..LSB}: {ABCD1, ABCD2, ABCD3, ABCD4}
 */
module d4BCDcounter(
    output wire[3:0] ABCD1, ABCD2, ABCD3, ABCD4,
    input EN, RST
);

    wire[3:0] CARRY;

    BCDcounter u_bcd[3:0] (
        .ABCD  ({ ABCD1,ABCD2,ABCD3,ABCD4 }),
        .CARRY ({ CARRY[3:0]     }),
        .EN    ({ CARRY[2:0], EN }),
        .RST   ( RST )
    );

endmodule