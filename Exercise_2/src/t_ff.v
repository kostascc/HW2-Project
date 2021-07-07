/**
 * Author:
 *   Shubham Pandey
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

/**
 * Master-Slave T-FF
 * negative edge triggered.
 * 
 * source: github.com/spdy1895
 */
module tff ( 
    output wire Q, Qn,
    input wire T, CLK, RST 
);

wire w1, w2, w3, w4, w5, w6, d;

// TODO: Change to positive edge triggered 

wire _CLK;
assign clk = _CLK;

not u0(_CLK, CLK);
not u1(_clk, clk);
not u2(_clr, RST);
not u3(_d, d);

xor ux(d, T, Q);

// Master
nand u4(w1, d, _clr, clk);
nand u5(w2, clk, _d);
nand u6(w3, w1, w4);
nand u7(w4, w3, _clr, w2);

// Slave
nand u8(w5, w3, _clr, _clk);
nand u9(w6, _clk, w4);
nand u10(Q, w5, Qn);
nand u11(Qn, Q, _clr, w6);


endmodule //dff
