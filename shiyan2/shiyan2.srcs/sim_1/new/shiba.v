`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/03 17:20:46
// Design Name: 
// Module Name: shiba
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


module shiba;
//Input
  reg [3:0]A;
  reg [3:0]B;
  reg Cin;
//Output
  wire [3:0]F;
  wire Cout;
  FAsi he(A,B,Cin,F,Cout);
  reg [8:0]T;
  initial
	begin
		T = 9'b0;
		forever #100 T = T + 1'b1;
	end

	always @(*)
		{B[3],A[3],B[2],A[2],B[1],A[1],B[0],A[0],Cin}=T;
  
endmodule
