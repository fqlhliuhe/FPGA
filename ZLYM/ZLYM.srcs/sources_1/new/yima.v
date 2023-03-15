`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/31 08:57:30
// Design Name: 
// Module Name: yima
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


module yima(inst,rs1,rs2,rd,imm32,opcode,funct3,funct7);
     input [31:0]inst;
     output [4:0]rs1;
     output [4:0]rs2;
     output [4:0]rd;
     output [31:0]imm32;
     output [6:0]opcode;
     output [2:0]funct3;
     output [6:0]funct7;
     wire [6:0]I_fmt;
     ID1 dd(inst,rs1,rs2,rd,I_fmt,opcode,funct3,funct7);
     ImmU ee(inst,I_fmt,imm32);
endmodule
