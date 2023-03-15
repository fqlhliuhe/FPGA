`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/02 19:40:37
// Design Name: 
// Module Name: xianjin
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
   output S
    );
    wire [3:1] T;
    xor U1(T[1],A,B);
    xor U2(S,T[1],CI);
    and U3(T[2],T[1],CI);
    and U4(T[3],A,B);
   
endmodule

module xianjin(A,B,Cin,C,Cout);
    input [3:0]A;
    input [3:0]B;
    input Cin;
    output [3:1]C;
    output Cout;
    assign C[1]=A[0]&B[0]|(A[0]|B[0])&Cin;//C1=A0B0+(A0+B0)C0
    assign C[2]=A[1]&B[1]|(A[1]|B[1])&A[0]&B[0]|(A[1]|B[1])&(A[0]|B[0])&Cin;//C2=A1B1+(A1+B1)A0B0+(A1+B1)(A0+B0)C0
    assign C[3]=A[2]&B[2]|(A[2]|B[2])&A[1]&B[1]|(A[2]|B[2])&(A[1]|B[1])&A[0]&B[0]|(A[2]|B[2])&(A[1]|B[1])&(A[0]|B[0])&Cin;//C3=A2B2+(A2+B2)A1B1+(A2+B2)(A1+B1)A0B0+(A2+B2)(A1+B1)(A0+B0)C0
    assign Cout=A[3]&B[3]|(A[3]|B[3])&A[2]&B[2]|(A[3]|B[3])&(A[2]|B[2])&A[1]&B[1]|(A[3]|B[3])&(A[2]|B[2])&(A[1]|B[1])&A[0]&B[0]|(A[3]|B[3])&(A[2]|B[2])&(A[1]|B[1])&(A[0]|B[0])&A[0]&B[0];//C4=A3B3+(A3+B3)A2B2+(A3+B3)(A2+B2)A1B1+(A3+B3)(A2+B2)(A1+B1)A0B0+(A3+B3)(A2+B2)(A1+B1)(A0+B0)A0B0
endmodule

module FAsi(A,B,Cin,F,Cout);
    input [3:0]A;
    input [3:0]B;
    input Cin;
    output [3:0]F;
    output Cout;
    wire [3:1]C;
    xianjin jiafa(A,B,Cin,C,Cout);
    FA FA0(A[0],B[0],Cin,F[0]),
       FA1(A[1],B[1],C[1],F[1]),
       FA2(A[2],B[2],C[2],F[2]),
       FA3(A[3],B[3],C[3],F[3]);
endmodule