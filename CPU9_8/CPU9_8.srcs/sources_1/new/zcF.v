`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/13 22:16:18
// Design Name: 
// Module Name: zcF
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


module zcF(rst_n,ALU_F,clk_fim,F);//FÔÝ´æÆ÷
   input rst_n;
   input [31:0]ALU_F;
   input clk_fim;
   output reg [31:0]F;
   always@(negedge rst_n or posedge clk_fim)
   begin 
      if(!rst_n)
         F<=32'b0;
      else
         F<=ALU_F;
   end
endmodule  
