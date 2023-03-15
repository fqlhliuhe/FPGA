`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/13 22:05:08
// Design Name: 
// Module Name: zcA
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
module zcA(rst_n,Data_A,clk_fim,ALU_A);//AÔÝ´æÆ÷
   input rst_n;
   input [31:0]Data_A;
   input clk_fim;
   output reg [31:0]ALU_A;
   always@(negedge rst_n or posedge clk_fim)
   begin 
      if(!rst_n)
         ALU_A<=32'b0;
      else
         ALU_A<=Data_A;
   end
endmodule
