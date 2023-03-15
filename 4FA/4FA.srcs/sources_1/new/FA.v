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
   input Cin,
   output S,
   output Cout
    );
    wire T1,T2,T3;
    xor xU1(T1,A,B),
        xU2(S,T1,Cin);
    and aU3(T2,T1,Cin),
        aU4(T3,A,B);
    or  oU5(Cout,T2,T3);
endmodule

module FAs(A,B,Cin,F,Cout);
    parameter SIZE=4;
    input [SIZE-1:0]A;
    input [SIZE-1:0]B;
    input Cin;
    output [SIZE-1:0]F;
    output Cout;
    wire [SIZE-1:1]C;
    FA FA0(A[0],B[0],Cin,F[0],C[1]),
       FA1(A[1],B[1],C[1],F[1],C[2]),
       FA2(A[2],B[2],C[2],F[2],C[2]),
       FA3(A[3],B[3],C[3],F[3],Cout);
endmodule