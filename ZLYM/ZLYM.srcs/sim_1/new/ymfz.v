`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/01 21:24:28
// Design Name: 
// Module Name: ymfz
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


module ymfz();
//INPUT
reg [31:0]inst;
//OUTPUT
wire [4:0]rs1;
wire [4:0]rs2;
wire [4:0]rd;
wire [31:0]imm32;
wire [6:0]opcode;
wire [2:0]funct3;
wire [6:0]funct7;
initial
   begin
      inst=32'h0000_02b3;//add  RÐÍ
      #50 inst=32'hfff3_8393;//addi IÐÍ 
      #50 inst=32'h09c0_2023;//SW   SÐÍ
   end
  yima kk(inst,rs1,rs2,rd,imm32,opcode,funct3,funct7);
endmodule