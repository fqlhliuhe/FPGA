`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/08 21:20:08
// Design Name: 
// Module Name: Reg
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
   reg[31:0]REG_Files[0:31];//�Ĵ�������
   assign R_Data_A=REG_Files[R_Addr_A];//��A����
   assign R_Data_B=REG_Files[R_Addr_B];//��B����
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
                 for(i=6;i<31;i=i+1) REG_Files[i]<=32'h0000_0000;//��ʼ��32�Ĵ���
              end
      else  
         begin
            if(Reg_Write&&W_Addr!=0)//������
              REG_Files[W_Addr]<=W_Data;//д��Ĵ���
         end
   end
endmodule