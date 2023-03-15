`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/31 22:24:30
// Design Name: 
// Module Name: IR
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


module IR(Inst_Code,clk_fim,IR_Write,inst);
    input [31:0]Inst_Code;
    input clk_fim;
    input IR_Write;
    output reg [31:0]inst;
    always@(posedge clk_fim)
    begin
    if(IR_Write==1)
       inst<=Inst_Code;
    end
endmodule
