`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/08 20:56:41
// Design Name: 
// Module Name: ID2
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


module ID2(opcode,funct3,funct7,IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,IS_BEQ,IS_JAL,IS_JALR,ALU_OP_in);
     input [6:0]opcode;
     input [2:0]funct3;
     input [6:0]funct7;
     output reg IS_R;
     output reg IS_IMM;
     output reg IS_LUI;
     output reg IS_LW;
     output reg IS_SW;
     output reg IS_BEQ;
     output reg IS_JAL;
     output reg IS_JALR;
     output reg [3:0]ALU_OP_in;
      always@(*)
      begin
      case(opcode)
           7'b0110011:begin //10R
                        IS_R=1;IS_IMM=0;IS_LUI=0;IS_LW=0;IS_SW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0;
                        ALU_OP_in={funct7[5],funct3};
                   end
           7'b0010011:begin //9I
                        IS_IMM=1;IS_R=0;IS_LUI=0;IS_LW=0;IS_SW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0;
                        ALU_OP_in=(funct3==3'b101)?{funct7[5],funct3}:{1'b0,funct3};
                   end
           7'b0110111: begin //lui
                       IS_LUI=1;IS_R=0;IS_IMM=0;IS_LW=0;IS_SW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0;
                       ALU_OP_in=4'b0000;
                   end
           7'b0000011: begin //lw
                       IS_LW=1;IS_R=0;IS_IMM=0;IS_LUI=0;IS_SW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0;
                       ALU_OP_in=4'b0000;
                   end
           7'b0100011: begin //sw
                       IS_SW=1;IS_R=0;IS_IMM=0;IS_LUI=0;IS_LW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0;
                       ALU_OP_in=4'b0000;
                   end
           7'b1100011: begin //beq
                       IS_SW=0;IS_R=0;IS_IMM=0;IS_LUI=0;IS_LW=0;IS_BEQ=1;IS_JAL=0;IS_JALR=0;
                       ALU_OP_in=4'b0000;
                   end
           7'b1101111: begin //jal
                       IS_SW=0;IS_R=0;IS_IMM=0;IS_LUI=0;IS_LW=0;IS_BEQ=0;IS_JAL=1;IS_JALR=0;
                       ALU_OP_in=4'b0000;
                   end
            7'b1100111: begin //jalr
                       IS_SW=0;IS_R=0;IS_IMM=0;IS_LUI=0;IS_LW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=1;
                       ALU_OP_in=4'b0000;
                   end               
           default:begin 
                    IS_R=0;IS_IMM=0;IS_LUI=0;IS_LW=0;IS_SW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0;
                    ALU_OP_in=4'b0000;
                end
     endcase
     end      
endmodule
