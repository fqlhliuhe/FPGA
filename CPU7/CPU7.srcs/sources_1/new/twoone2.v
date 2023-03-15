`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/13 21:42:47
// Design Name: 
// Module Name: twoone2
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


module twoone2(w_data_s,imm32,F,W_Data);
   input w_data_s;
   input [31:0]imm32;
   input [31:0]F;
   output reg [31:0]W_Data;
   always@(*)
   begin
       case(w_data_s)
              0:begin W_Data=F; end
              1:begin W_Data=imm32; end
       endcase
   end
endmodule
