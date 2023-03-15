`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/13 22:17:20
// Design Name: 
// Module Name: FR
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


module FR(clk_F,rst_n,ZF,SF,CF,OF,FR);//FR±êÖ¾¼Ä´æÆ÷
   input clk_F;
   input rst_n;
   input ZF,SF,CF,OF;
   output reg [3:0]FR;
   always@(negedge rst_n or posedge clk_F)
   begin 
      if(!rst_n)
         FR<=4'b0;
      else
         begin
            FR[3]=ZF;
            FR[2]=SF;
            FR[1]=CF;
            FR[0]=OF;
         end
   end
endmodule