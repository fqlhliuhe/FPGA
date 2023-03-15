`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/10 19:55:10
// Design Name: 
// Module Name: REG
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
module dcen(rst_n,
            R_Addr_A,R_Addr_B,W_Addr,Reg_Write,clk_WB,
            clk_1M,CLR,clk_RR,clk_F,ALU_OP,choose,FR,AN,seg);
   input rst_n;
   //¼Ä´æÆ÷¶Ñ
   input [4:0]R_Addr_A;
   input [4:0]R_Addr_B;
   input [4:0]W_Addr;
   input Reg_Write;
   input clk_WB;
   wire [31:0]W_Data;
   wire [31:0]R_Data_A;
   wire [31:0]R_Data_B;
  //ALU
  input clk_1M;
  input CLR;
  input clk_RR;
  input clk_F;
  input [3:0]ALU_OP;
  input [1:0]choose;
  output [3:0]FR;
  output [7:0]AN;
  output [7:0]seg;
  Reg hh(rst_n,R_Addr_A,R_Addr_B,W_Addr,Reg_Write,W_Data,clk_WB,R_Data_A,R_Data_B);         
  dingceng kk(R_Data_A,R_Data_B,clk_1M,CLR,rst_n,clk_RR,clk_F,ALU_OP,choose,W_Data,FR,AN,seg);
endmodule

module Reg(rst_n,R_Addr_A,R_Addr_B,W_Addr,Reg_Write,W_Data,clk_Regs,R_Data_A,R_Data_B);
   input rst_n;
   input [4:0]R_Addr_A;
   input [4:0]R_Addr_B;
   input [4:0]W_Addr;
   input Reg_Write;
   input [31:0]W_Data;
   input clk_Regs;
   output [31:0]R_Data_A;
   output [31:0]R_Data_B;
   integer i;
   wire clk;
   reg[31:0]REG_Files[0:31];//¼Ä´æÆ÷ÕóÁÐ
   assign R_Data_A=REG_Files[R_Addr_A];//¶ÁA²Ù×÷
   assign R_Data_B=REG_Files[R_Addr_B];//¶ÁB²Ù×÷
   always@(posedge clk_Regs or negedge rst_n)
   begin
      if(!rst_n)
              begin
                 REG_Files[0]<=32'h0000_0000;
                 REG_Files[1]<=32'h0000_0001;
                 REG_Files[2]<=32'h0000_0004;
                 REG_Files[3]<=32'hFFF8_0f0f;
                 REG_Files[4]<=32'hFFF8_0001;
                 REG_Files[5]<=32'hFFF8_0002;
                 for(i=6;i<31;i=i+1) REG_Files[i]<=32'h0000_0000;//³õÊ¼»¯32¼Ä´æÆ÷
              end
      else  
         begin
            if(Reg_Write&&W_Addr!=0)//ÉÏÌøÑØ
              REG_Files[W_Addr]<=W_Data;//Ð´Èë¼Ä´æÆ÷
         end
   end
endmodule