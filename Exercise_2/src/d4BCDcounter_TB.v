/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
 
 `timescale 10ns/1ns

module d4BCDcounter_TB;

    reg EN, RST;

    wire[3:0] ABCD[3:0];
    d4BCDcounter dut(
        .ABCD4( ABCD[0] ),
        .ABCD3( ABCD[1] ),
        .ABCD2( ABCD[2] ),
        .ABCD1( ABCD[3] ),
        .EN(EN),
        .RST(RST)
    );

    integer iout, i1, i2, i3, i4;
    integer expectediOut;

    assign i1 = {ABCD[0][3:0]};
    assign     i2 = {ABCD[1][3:0]};
    assign    i3 = {ABCD[2][3:0]};
    assign     i4 = {ABCD[3][3:0]};
    assign iout = i1 + 10*i2 + 100*i3 + 1000*i4;

    // always @begin
    //     #0.1;
    //     iout <= i1 + 10*i2 + 100*i3 + 1000*i4;
    // end

    initial begin
        expectediOut = 0;
        iout = 0;
        RST = 1'b1;
        EN  = 1'b0;

        #1;
        RST = 1'b0;
    end

    always begin
        #4;
        while(1'b1) begin
            #1;
            if (expectediOut != iout) begin
                $display("Wrong output at %d",expectediOut);
            end
            #1 EN = ~EN;
            if (EN==1'b1) begin
                expectediOut = expectediOut+1;
            end
            if(expectediOut > 9999) begin
                expectediOut = 0;
            end
        end

    end

endmodule