`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/31 22:29:54
// Design Name: 
// Module Name: ImmU
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


module ImmU(funct3,inst,I_fmt,imm32);
     input [2:0]funct3;
     input [31:0]inst;
     input [6:0]I_fmt;
     output reg [31:0]imm32;
     wire [31:0]I_imm;
     wire [31:0]S_imm;
     wire [31:0]B_imm;
     wire [31:0]U_imm;
     wire [31:0]J_imm;
     wire [31:0]JALR_imm;
     assign I_imm={{20{inst[31]}},inst[31:20]};
     assign S_imm={{20{inst[31]}},inst[31:25],inst[11:7]};
     assign B_imm={{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0};
     assign U_imm={inst[31:12],{12{1'b0}}};
     assign J_imm={{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0};
     always@(*)
        begin
           case(I_fmt)
                7'b0100000: begin //I
                                if(funct3==3'b101||funct3==3'b001)
                                   imm32={{27{1'b0}},inst[24:20]};
                                else
                                   imm32=I_imm;
                             end
                7'b0010000: imm32=S_imm;//S
                7'b0001000: imm32=B_imm;//B
                7'b0000100: imm32=U_imm;//U
                7'b0000010: imm32=J_imm;//J
                7'b0000001: begin 
                                if(funct3==3'b101||funct3==3'b001)
                                   imm32={{27{1'b0}},inst[24:20]};
                                else
                                   imm32=I_imm;
                             end
                default:imm32=0;
           endcase
        end
endmodule
