/**
 * Author:
 *   Konstantinos Chatzis
 *   June 2021
 *   kachatzis <at> ece.auth.gr
 */
 `timescale 1ns/1ns

 /**
  * Encodes a 12bit signal based
  * on the Hamming (12,5) code
  */
 module hamEncode125(
    output reg[17:1]  OUT,
    input  wire[11:0]  IN
);

    // Output consisting of 
    // input and Parity bits
    assign OUT = {
        IN[11], //17
        PAR[4],   //16
        IN[10], //15
        IN[9],  //14
        IN[8],  //13
        IN[7],  //12
        IN[6],  //11
        IN[5],  //10
        IN[4],  //9
        PAR[3],   //8
        IN[3],  //7
        IN[2],  //6
        IN[1],  //5
        PAR[2],   //4
        IN[0],  //3
        PAR[1],   //2
        PAR[0]    //1
    };

    // Parity Bits
    reg[4:0] PAR;

    assign PAR[0]  = OUT[3]  ^ OUT[5]  ^ 
                     OUT[7]  ^ OUT[9]  ^ OUT[11] ^ 
                     OUT[13] ^ OUT[15] ^ OUT[17] ;

    assign PAR[1]  = OUT[3]  ^
                     OUT[6]  ^ OUT[7]  ^
                     OUT[10] ^ OUT[11] ^
                     OUT[14] ^ OUT[15];

    assign PAR[2]  = OUT[5]  ^ OUT[6]  ^ OUT[7]  ^
                     OUT[12] ^ OUT[13] ^ OUT[14] ^ OUT[15] ;

    assign PAR[3]  = OUT[9]  ^ OUT[10] ^ OUT[11] ^ OUT[12] ;

    assign PAR[4]  = OUT[17] ;

endmodule