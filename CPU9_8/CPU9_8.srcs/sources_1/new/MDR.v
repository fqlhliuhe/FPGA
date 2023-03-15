`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/16 11:11:54
// Design Name: 
// Module Name: MDR
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


module MDR(M_R_Data,clk_fim,rst_n,MDR_data);
   input [31:0]M_R_Data;
   input clk_fim;
   input rst_n;
   output reg [31:0]MDR_data;
   always@(negedge rst_n or posedge clk_fim)
   begin 
      if(!rst_n)
         MDR_data<=32'b0;
      else
         MDR_data<=M_R_Data;
   end
endmodule
