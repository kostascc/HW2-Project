/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

/**
 * Master-Slave T-FF
 * Positive Edge Triggered,
 * RST is active-HIGH.
 */
module t_ff ( 
    output wire Q, Qn,
    input wire RST, T, CLK 
);

wire j, k;
assign j = T;
assign k = T;

wire RSTn, CLKn;
not u_nrst (RSTn, RST);
not u_nclk (CLKn, CLK);

// Slave
nand n0(Q, e, Qn);
nand n1(Qn, f, RSTn, Q);
nand n2(e, c, RSTn, CLK);
nand n3(f, d, CLK);

// Master
nand n4(c, a, d);
nand n5(d, b, c, RSTn);
nand n6(a, j, CLKn, Qn, RSTn);
nand n7(b, k, CLKn, Q);

endmodule
