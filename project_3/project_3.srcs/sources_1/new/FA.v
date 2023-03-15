`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/28 20:10:14
// Design Name: 
// Module Name: FA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//

module FA(
   input A,
   input B,
   input CI,
   output S,
   output CO
    );
    wire [3:1] T;
    xor U1(T[1],A,B);
    xor U2(S,T[1],CI);
    and U3(T[2],T[1],CI);
    and U4(T[3],A,B);
    or U5(CO,T[2],T[3]);
   
endmodule
