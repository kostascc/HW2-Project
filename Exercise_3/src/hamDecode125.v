/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */

 /**
  * Decodes a 17bit signal
  * based on the Hamming (12,5)
  * coding scheme.
  */
module hamDecode125(
    output wire[12:1] OUT,
    input  wire[17:1] IN
);

    wire[5:1] PAR;
    reg[17:1] RE;

    // Parity bits
    assign PAR[1]  = IN[1]  ^ IN[3]  ^ IN[5]  ^ 
                     IN[7]  ^ IN[9]  ^ IN[11] ^ 
                     IN[13] ^ IN[15] ^ IN[17] ;

    assign PAR[2]  = IN[2]  ^ IN[3]  ^
                     IN[6]  ^ IN[7]  ^
                     IN[10] ^ IN[11] ^
                     IN[14] ^ IN[15];

    assign PAR[3]  = IN[4]  ^ IN[5]  ^ IN[6]  ^ IN[7]  ^
                     IN[12] ^ IN[13] ^ IN[14] ^ IN[15] ;

    assign PAR[4]  = IN[8]  ^ IN[9]  ^ IN[10] ^ IN[11] ^ IN[12] ;

    assign PAR[5]  = IN[16] ^ IN[17] ;

    // Output
    assign OUT = {RE[17], RE[15:9], RE[7:5], RE[3]};

    // Apply error correction to output
    always @(IN) begin: ERROR_CORRECTION
        RE = IN;

        // Apply Error Correction
        case (PAR)
            0:  disable ERROR_CORRECTION;
            default: {RE[PAR]} = ~{RE[PAR]};
        endcase
    end

endmodule