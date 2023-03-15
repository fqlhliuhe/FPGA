`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/31 14:04:52
// Design Name: 
// Module Name: FourBitFA
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
               FA3(.Sum(Sum[3]), .Cout(Cout), .A(X[3]),,B(Y[3]),.Cin(C[3]));   
endmodule
