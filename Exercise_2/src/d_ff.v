/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
module d_ff (
    output wire Q, Qn,
    input wire D, CLK, RST
);

wire n1, n2, n3, n4, n5, n6;

not u1(_CLK, CLK);
not u2(_RST, RST);
not u3(_D, D);

// Master
nand u4(n1, D, _RST, _CLK);
nand u5(n2, _CLK, _D);
nand u6(n3, n1, n4);
nand u7(n4, n3, _RST, n2);

// Slave
nand u8(n5, n3, _RST, CLK);
nand u9(n6, CLK, n4);
nand u10(Q, n5, Qn);
nand u11(Qn, Q, _RST, n6);

endmodule