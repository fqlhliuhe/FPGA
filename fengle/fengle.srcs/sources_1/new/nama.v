`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/31 15:06:57
// Design Name: 
// Module Name: nama
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

module FAsi(A,B,Cin,F,Cout);
    input [3:0]A;
    input [3:0]B;
    input Cin;
    output [3:0]F;
    output Cout;
    wire [3:1]C;
    FA FA0(A[0],B[0],Cin,F[0],C[1]),
       FA1(A[1],B[1],C[1],F[1],C[2]),
       FA2(A[2],B[2],C[2],F[2],C[3]),
       FA3(A[3],B[3],C[3],F[3],Cout);
endmodule
