`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/31 13:28:41
// Design Name: 
// Module Name: Full_Adder
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


module Full_Adder(Sum,Cout,A,B,Cin);
    output Sum,Cout;
    input A,B,Cin;
    wire S1,T1,T2,T3;
    xor XU1(S1,A,B),
        XU2(Sum,S1,Cin);
    and AU1(S1,A,B),
        AU2(T2,A,Cin),
        AU3(T3,B,Cin);
    or OU1(Cout,T1,T2,T3);
endmodule

module FourBitFA(X,Y,Cin,Sum,Cout);
    parameter SIZE=4;
    input [SIZE-1:0]X,Y;
    output [SIZE-1:0] Sum;
    input Cin;
    output Cout;
    wire [SIZE-1:1]C;
    Full_Adder FA0(Sum[0],C[1],X[0],Y[0],Cin),
               FA1(Sum[1],C[2],X[1],Y[1],C[1]),
               FA2(.A(X[2]),.B(Y[2]), .Cin(C[2]), .Sum(Sum[2]),.Cout(C[3]));
               FA3(Sum[3],Cout,X[3],Y[3],C[3]);   
endmodule