/**
 * INIT: Initialization Port (Active-LOW)
**/
module t_ff( Q, Qbar, T, CLK, INIT);

    output Q, Qbar;
    input T, CLK, INIT;
    supply0 GND;
    supply1 VDD;

    // JK Latch in Master-Slave formation
    not u3 (nCLKbar, CLK);

    bufif1 (nJ, T, INIT);
    bufif1 (nK, T, INIT);

    bufif0 (nJ, GND, INIT);
    bufif0 (nK, VDD, INIT);

    jk_latch u1 (.Q(nu1), .Qbar(nu2), .CLK(CLK), .J(nJ), .K(nK), .s1(Qbar), .s2(Q));

    jk_latch u2 (.Q(Q), .Qbar(Qbar), .CLK(nCLKbar), .J(nu1), .K(nu2), .s1(nCLKbar), .s2(nCLKbar));


endmodule
