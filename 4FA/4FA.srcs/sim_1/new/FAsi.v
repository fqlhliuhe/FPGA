`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/29 18:26:13
// Design Name: 
// Module Name: FAsi
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


module FAsi(A,B,C0,F,C4);
    input [3:0]A;
    input [3:0]B;
    input C0;
    output [3:0]F;
    output C4;
    wire [3:1]C;
    FA FA0(F[0],C[1],A[0],B[0],C0),
       FA1(F[1],C[2],A[1],B[1],C[1]),
       FA2(
            .A(A[2]),
            .B(B[2]),
            .CO(C[2]),
            .F(F[2]),
            .C4(C[3])),
       FA3(
             .F(F[3]),
             .C4(C4),
             .A(A[3]),
             .B(B[3]),
             .C0(C[3]));
endmodule
