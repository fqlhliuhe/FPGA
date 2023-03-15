`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/01 21:04:27
// Design Name: 
// Module Name: ID1
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


module ID1(inst,rs1,rs2,rd,I_fmt,opcode,funct3,funct7);
     input [31:0]inst;
     output [4:0]rs1;
     output [4:0]rs2;
     output [4:0]rd;
     output [6:0]I_fmt;
     output [6:0]opcode;
     output [2:0]funct3;
     output [6:0]funct7;
     wire R_Type,I_Type,S_Type,B_Type,U_Type,J_Type,YW_Type;
  assign I_fmt={R_Type,I_Type,S_Type,B_Type,U_Type,J_Type,YW_Type};
  `define OP_R  7'b0110011
  assign R_Type=(opcode==`OP_R);
  `define OP_I1  7'b0010011
  `define OP_I2  7'b0000011
  assign I_Type=(opcode==`OP_I1||opcode==`OP_I2);
  `define OP_S  7'b0100011
  assign S_Type=(opcode==`OP_S);
  `define OP_B  7'b1100011
  assign B_Type=(opcode==`OP_B);
  `define OP_U1  7'b0110111  
  `define OP_U2  7'b0010111
  assign U_Type=(opcode==`OP_U1||opcode==`OP_U2);
  `define OP_J  7'b1101111
  assign J_Type=(opcode==`OP_J);
  `define OP_I3  7'b1100111
  assign YW_Type=(opcode==`OP_I3);
  assign opcode=inst[6:0];
  assign rs1=inst[19:15];
  assign rs2=inst[24:20];
  assign rd=inst[11:7];
  assign funct3=inst[14:12];	
  assign funct7=inst[31:25];
endmodule