`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/13 20:52:22
// Design Name: 
// Module Name: CPU_D
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


module CPU_D(clk_1M,CLR,rst_n,clk,SW,FR,AN,seg/*Choice*/);
   input clk_1M;
   input CLR;
   input rst_n;
   input clk;
   input [2:0]SW;
   output [3:0]FR;
   output [7:0]AN;
   output [7:0]seg;
   wire clk_fim;
   wire PC_Write;
   wire [31:0]PC_Out;
   wire [31:0]Inst_Code;
   wire IR_Write;
   wire [31:0]inst;
   wire [4:0]rs1;
   wire [4:0]rs2;
   wire [4:0]rd;
   wire [6:0]I_fmt;
   wire [6:0]opcode;
   wire [2:0]funct3;
   wire [6:0]funct7;
   wire IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW;
   wire [3:0]ALU_OP_in;
   wire Reg_Write;
   wire [3:0]ALU_OP;
   wire rs2_imm_s;
   wire [1:0]w_data_s; 
   wire [31:0]imm32;
   wire [31:0]W_Data;
   wire [31:0]R_Data_A;
   wire [31:0]R_Data_B;
   wire [31:0]ALU_A;
   wire [31:0]ALU_B;
   wire [31:0]B;
   wire [31:0]ALU_F;
   wire ZF,SF,CF,OF;
   wire [31:0]F;
   wire Mem_Write;
   wire [31:0]M_R_Data;
   wire [31:0]MDR_data;
   wire [31:0]Choice;
   //output [31:0]Choice;
   wire CLK;
   assign clk_fim=~clk;
   PC aa(rst_n,PC_Write,clk_fim,PC_Out);
   RAM_B IM(     //´æ´¢Æ÷
  .clka(clk),    // input wire clka
  .addra(PC_Out[7:2]),  // input wire [5 : 0] addra
  .douta(Inst_Code)  // output wire [31 : 0] douta
  );
   IR bb(Inst_Code,clk_fim,IR_Write,inst);
   ID1 cc(inst,rs1,rs2,rd,I_fmt,opcode,funct3,funct7);
   ID2 qq(opcode,funct3,funct7,IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,ALU_OP_in);
   CU dd(clk,rst_n,IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,ALU_OP_in,PC_Write,IR_Write,Reg_Write,rs2_imm_s,w_data_s,Mem_Write,ALU_OP);
   ImmU ee(inst,I_fmt,imm32);
   Reg ff(rst_n,rs1,rs2,rd,Reg_Write,W_Data,clk_fim,R_Data_A,R_Data_B);
   zcA gg(rst_n,R_Data_A,clk_fim,ALU_A);
   zcB hh(rst_n,R_Data_B,clk_fim,ALU_B);
   twoone1 ii(rs2_imm_s,ALU_B,imm32,B);
   ALU jj(ALU_OP,ALU_A,B,ALU_F,ZF,SF,CF,OF);
   zcF kk(rst_n,ALU_F,clk_fim,F);
   RAM_C DM(
  .clka(clk),    // input wire clka
  .wea(Mem_Write),      // input wire [0 : 0] wea
  .addra(F[7:2]),  // input wire [5 : 0] addra
  .dina(ALU_B),    // input wire [31 : 0] dina
  .douta(M_R_Data)  // output wire [31 : 0] douta
);
   MDR rr(M_R_Data,clk_fim,rst_n,MDR_data);
   threeone2 ll(w_data_s,imm32,F,MDR_data,W_Data);
   FR mm(clk_fim,rst_n,ZF,SF,CF,OF,FR);
   sevenone nn(SW,PC_Out,inst,W_Data,ALU_A,ALU_B,F,MDR_data,Choice);
   fpq oo(CLR,clk_1M,CLK);
   smgsm pp(CLK,CLR,Choice,AN,seg);
endmodule
