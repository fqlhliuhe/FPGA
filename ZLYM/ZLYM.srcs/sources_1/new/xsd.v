`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/01 08:46:08
// Design Name: 
// Module Name: xsd
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


module xsd(K,rs1,rs2,rd,opcode,funct3,funct7,LED);
    input K;
    input [4:0]rs1,rs2,rd;
    input [6:0]opcode;
    input [2:0]funct3;
    input [6:0]funct7;
    output reg [16:0]LED;
    always@(*)
    begin
       case(K)
            0: begin     
                  LED[16:12]=rs1;
                  LED[11:7]=rs2;
                  LED[6:2]=rd;
                  LED[1:0]=2'b00;
               end
            1: begin     
                  LED[16:10]=opcode;
                  LED[9:7]=funct3;
                  LED[6:0]=funct7;
               end
       endcase
    end
endmodule
