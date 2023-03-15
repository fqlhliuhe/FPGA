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


module fourone2(w_data_s,imm32,F,MDR_data,PC_Out,W_Data);
   input [1:0]w_data_s;
   input [31:0]imm32;
   input [31:0]F;
   input [31:0]MDR_data;
   input [31:0]PC_Out;
   output reg [31:0]W_Data;
   always@(*)
   begin
       case(w_data_s)
              2'b00:begin W_Data=F; end
              2'b01:begin W_Data=imm32; end
              2'b10:begin W_Data=MDR_data; end
              2'b11:begin W_Data=PC_Out; end
       endcase
   end
endmodule
