`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/13 21:40:26
// Design Name: 
// Module Name: twoone1
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


module twoone1(rs2_imm_s,ALU_B,imm32,B);
   input rs2_imm_s;
   input [31:0]ALU_B;
   input [31:0]imm32;
   output reg [31:0]B;
   always@(*)
   begin
       case(rs2_imm_s)
              0:begin B=ALU_B; end
              1:begin B=imm32; end
       endcase
   end
endmodule
