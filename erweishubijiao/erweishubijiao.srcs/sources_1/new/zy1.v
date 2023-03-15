`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/19 18:27:04
// Design Name: 
// Module Name: zy1
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
//数据流描述方式

module zy1(A0,A1,B0,B1,F);
wire A0,A1,B0,B1,F;
input A0,A1,B0,B1;
output reg F;
assign F=((~A1&~B1)|(A1&B1))&((~A0&~B0)|(A0&B0));
endmodule

//行为描述方式
/*
module zy1(
   input A0,
   input A1,
   input B0,
   input B1,
   output reg F
   );
   always @(*)
   begin
   F=((~A1&~B1)|(A1&B1))&((~A0&~B0)|(A0&B0));
   end
endmodule
*/
//结构描述方式
/*
moudle zy1(
  input A0,
  input A1,
  input B0,
  input B1,
  output F
  );
  wire [3;1]T;
  xor XU1(T[1],A0,B0),
      XU2(T[2],A1,B1);
  and XU3(T[3],T[1],T[2]);
endmoudle
*/