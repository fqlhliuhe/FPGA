`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/17 20:12:40
// Design Name: 
// Module Name: PC0
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


module PC0(clk_fim,rst_n,PC0_Write,PC_Out,PC_1);
    input clk_fim;
    input rst_n;
    input PC0_Write;
    input [31:0]PC_Out;
    output reg [31:0]PC_1;
    always@(posedge clk_fim or negedge rst_n)
    begin
         if(!rst_n)
              PC_1<=0;
         else
          begin
             if(PC0_Write)
                PC_1<=PC_Out;
          end
    end
endmodule
