/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

 /**
  * Accepts a 12bit input signal.
  * The input is encoded based on 
  * Hamming (12,5). A bit error is
  * imposed on the encoded signal.
  * The signal is the decoded again,
  * and the output should again be the
  * same as the input.
  */
module test_HD_codec(
    output wire[11:0] OUT,
    input wire[11:0] IN, 
    input wire[31:0] error_bit
);
    reg[16:0]  noiOUT;
    wire[16:0] encOUT;

    // Encoder
    hamEncode125 u_enc (
        .IN(IN),
        .OUT(encOUT)
    );

    // Decoder
    hamDecode125 u_dec (
        .IN(noiOUT),
        .OUT(OUT)
    );

    // Impose a bit error
    always @(IN) begin
        if(error_bit > 11) begin
            noiOUT = encOUT;
        end else begin
            noiOUT = encOUT;
            noiOUT[error_bit] = ~noiOUT[error_bit];
        end
    end

endmodule