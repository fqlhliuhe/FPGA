`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/17 20:16:49
// Design Name: 
// Module Name: PC_threeone
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


module PC_threeone(PC_s,imm32,PC_Out,PC_1,F,PC_in);
    input [1:0]PC_s;
    input [31:0]imm32;
    input [31:0]PC_Out;
    input [31:0]PC_1;
    input [31:0]F;
    output reg [31:0]PC_in;
    always@(*)
    begin
       case(PC_s)
              2'b00:begin PC_in=PC_Out+4; end
              2'b01:begin PC_in=PC_1+imm32; end
              2'b10:begin PC_in=F; end
       endcase
    end
endmodule
