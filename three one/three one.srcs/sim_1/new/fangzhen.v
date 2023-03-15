`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/11 19:59:29
// Design Name: 
// Module Name: fangzhen
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


module fangzhen;
  //INPUT
  reg [1:0] A,B,C,D,S;
  reg _EN_;
  //OUYPUT
  wire [1:0] Y;
  reg [1:11]T;
  huangle chioce(A,B,C,D,S,_EN_,Y);
  initial
	begin
		T = 11'b0;
		forever #100 T = T + 1'b1;
	end
	always @(*)
		{_EN_,S,A,B,C,D}=T;
endmodule

