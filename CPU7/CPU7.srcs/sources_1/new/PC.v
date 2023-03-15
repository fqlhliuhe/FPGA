`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/31 22:22:11
// Design Name: 
// Module Name: PC
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


module PC(rst_n,PC_Write,clk_fim,PC_Out);//³ÌÐò¼ÆÊýÆ÷PC
    input rst_n;
    input PC_Write;
    input clk_fim;
    output reg [31:0]PC_Out;
    initial 
       begin  
             PC_Out<=0;
       end
    always@(posedge clk_fim or posedge rst_n)
    begin
        if(rst_n==0)
              PC_Out<=0;
        else
            begin
                if(PC_Write==1)
                     PC_Out<=PC_Out+4;
                else
                     PC_Out<=PC_Out;
            end
    end
endmodule
