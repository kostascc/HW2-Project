/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

/**
 * This module converts a BCD 4-bit
 * number, to a 7 Segment LED. 
 * 
 * ABCD         :   4-bit BCD Signal
 * LED          :   7 Segment Signal
 * LED_type_ctl :   LOW  = Common Cathode
 *                  HIGH = Common Anode
 */
module BCDto7Seg (
    output wire[6:0] LED,   // 7 Seg.
    input wire[3:0] ABCD,   // BCD
    input LED_type_ctl      // LED type
);

    wire A,B,C,D,a,b,c,d,e,f,g;

    assign {A,B,C,D}  = {ABCD[3:0]}     ;
    assign {LED[6:0]} = {a,b,c,d,e,f,g} ;

    // Inverters
    not u_An (_A, A),
        u_Bn (_B, B),
        u_Cn (_C, C),
        u_Dn (_D, D);

    // AND gates
    and u_BnDn (BnDn, _B, _D),
        u_BD   (BD,    B,  D),
        u_BDn  (BDn,   B, _D),
        u_CnDn (CnDn, _C, _D),
        u_CD   (CD,    C,  D),
        u_CDn  (CDn,   C, _D),
        u_BCn  (BCn,   B, _C),
        u_BnC  (BnC,  _B,  C),
        u_BCnD (BCnD,  B, _C,  D);
    
    // OR gates
    or  // a
        u_a1    (n_a1,    A,    C,   BD),
        u_a0    (na,   n_a1, BnDn      ),
        // b
        u_b0    (nb,     _B, CnDn,   CD),
        // c
        u_c0    (nc,      B,   _C,    D),
        // d
        u_d1    (n_d1, BnDn,  CDn, BCnD),
        u_d0    (nd,   n_d1,  BnC,    A),
        // e
        u_e0    (ne,   BnDn,  CDn      ),
        // f
        u_f1    (n_f1,    A, CnDn,  BCn),
        u_f0    (nf,   n_f1,  BDn      ),
        // g
        u_g1    (n_g1,    A,  BCn,  BnC),
        u_g0    (ng,   n_g1,  CDn      );

    // Tristate Buffers
    // (controlling the LED output type)
    bufif0  u_bf[6:0] ({a,b,c,d,e,f,g}, {na,nb,nc,nd,ne,nf,ng}, LED_type_ctl);
    notif1  u_nf[6:0] ({a,b,c,d,e,f,g}, {na,nb,nc,nd,ne,nf,ng}, LED_type_ctl);

endmodule