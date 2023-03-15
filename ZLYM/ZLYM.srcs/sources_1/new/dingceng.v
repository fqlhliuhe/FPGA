`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/01 21:23:53
// Design Name: 
// Module Name: dingceng
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


module dingceng(CLR,clk_1M,SW,K,rst_n,IR_Write,PC_Write,clk_im,LED,AN,seg);
   input CLR;
   input clk_1M;
   input [1:0]SW;
   input K;
   input rst_n;
   input IR_Write;
   input PC_Write;
   input clk_im;
   output [16:0]LED;
   output [7:0]AN,seg;
   wire [4:0]rs1;
   wire [4:0]rs2;
   wire [4:0]rd;
   wire [6:0]opcode;
   wire [2:0]funct3;
   wire [6:0]funct7;
   wire [31:0]PC,inst,imm32,F;
   wire CLK;
   zhilin oo(rst_n,IR_Write,PC_Write,clk_im,inst,PC);
   yima pp(inst,rs1,rs2,rd,imm32,opcode,funct3,funct7);
   threeone qq(SW,PC,inst,imm32,F);
   xsd rr(K,rs1,rs2,rd,opcode,funct3,funct7,LED[16:0]);
   fpq ss(CLR,clk_1M,CLK);
   smgsm tt(CLK,CLR,F,AN,seg);
endmodule
