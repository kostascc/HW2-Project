/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

/**
 * The BCDcounter is a single-digit decade
 * up-counter (with a range from 0 to 9). 
 * It works by applying a pulse to the 'EN'
 * port. 
 * Other than the BCD number at the output
 * (ABCD), it returns a CARRY signal which
 * generates a pulse every time a decade
 * has passed.
 *
 * All signals are Active-HIGH!
 * EN & RST are Asynchronous.
 */
module BCDcounter(
    output wire[3:0] ABCD, 
    output wire CARRY,
    input EN, RST
);
    
    supply1 vdd;
    wire A, B, C, D;
    assign {ABCD[3:0]} = {D,C,B,A};

    wire An, Bn, Cn, Dn;

    assign CARRY = Dn;

    // AND gates
    and u_a1 (n_a1, A, Dn  ),
        u_a2 (n_a2, B, A   ),
        u_a3 (n_a3, D, A   ),
        u_a4 (n_a4, C, n_a2);

    // OR gate
    or  u_o5 (n_o5, n_a3, n_a4);

    // T-FFs
    t_ff u_t[3:0] (
        .T ({vdd, n_a1, n_a2, n_o5}),
        .Q ({A , B , C , D }),
        .Qn({An, Bn, Cn, Dn}),
        .RST(RST),
        .CLK(EN)
    );

endmodule