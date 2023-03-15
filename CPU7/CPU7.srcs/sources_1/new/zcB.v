`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/13 22:14:04
// Design Name: 
// Module Name: zcB
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


module zcB(rst_n,Data_B,clk_B,ALU_B);//BÔÝ´æÆ÷
   input rst_n;
   input [31:0]Data_B;
   input clk_B;
   output reg [31:0]ALU_B;
   always@(negedge rst_n or posedge clk_B)
   begin 
      if(!rst_n)
         ALU_B<=32'b0;
      else
         ALU_B<=Data_B;
   end
endmodule
