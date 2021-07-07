module 4dBCDcounter(
    output wire[3:0] ABCD[3:0],
    input EN, RST,
);

    wire[3:0] CARRY;

    BCDcounter[3:0] u_bcd (
        .ABCD  ({ ABCD[3:0][3:0] }),
        .CARRY ({ CARRY[3:0]     }),
        .EN    ({ CARRY[2:0], EN }),
        .RST   ( RST ),
    );

    // TODO: Create TB

endmodule