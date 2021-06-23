module jk_latch (
    output Q, Qbar, 
    input J, K, CLK, s1, s2);

    nand u1 (n1, J, s1, CLK);
    nand u2 (n2, K, s2, CLK);

    nand u3 (Q, n1, Qbar);
    nand u4 (Qbar, n2, Q);

endmodule