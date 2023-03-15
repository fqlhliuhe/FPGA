`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/29 11:59:10
// Design Name: 
// Module Name: zlym
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


module zlym();

endmodule




module PC(PC_Data,PC_Write,clk_fim,PC_Out);//程序计数器PC
    input [31:0]PC_Data;
    input PC_Write;
    input clk_fim;
    output reg [31:0]PC_Out;
    initial 
       begin  
             PC_Out<= -4;  
       end
    always@(posedge clk_fim)
    begin
    if(PC_Write==1)
       PC_Out<=PC_Data;
    else
       PC_Out<=PC_Out;
    end
endmodule

module PCADD(PC_Out,PC_Data);//PC自增加法器
   input [31:0]PC_Out;
   output [31:0]PC_Data;
       assign PC_Data=PC_Out+4;
endmodule


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
