`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/01 23:06:24
// Design Name: 
// Module Name: threeone
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


module threeone(SW,PC,inst,imm32,F);//三选一A,B,F输出到数码管显示
   input [1:0]SW;
   input [31:0]PC;
   input [31:0]inst;
   input [31:0]imm32;
   output reg [31:0]F;
   always@(*)
   begin
       case(SW)
              2'b00:begin F=PC; end
              2'b01:begin F=inst; end
              2'b10:begin F=imm32; end
              default:begin F=PC; end  
       endcase
   end
endmodule
