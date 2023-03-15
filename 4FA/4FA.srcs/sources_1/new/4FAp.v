`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/31 11:22:17
// Design Name: 
// Module Name: 4FAp
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


module 4FAp(A,B,Cin,F,C4);
    parameter SIZE=4;
    input [SIZE-1:0]A;
    input [SIZE-1:0]B;
    input Cin;
    output [SIZE-1:0]F;
    output C4;
    wire [SIZE-1:1]C;
    FA FA0(A[0],B[0],Cin,F[0],C[1]),
       FA1(A[1],B[1],C[1],F[1],C[2]),
       FA2(A[2],B[2],C[2],F[2],C[2]),
       FA3(A[3],B[3],C[3],F[3],C4);
endmodule

