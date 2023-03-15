`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/31 22:00:27
// Design Name: 
// Module Name: qzfz
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


module qzfz();
//INPUT
reg rst_n;
reg IR_Write;
reg PC_Write;
reg clk_im;
//OUTPUT
wire [31:0]inst;

initial
   begin
      rst_n=1;clk_im=0;IR_Write=0;PC_Write=1;
   end
always
    begin
       #200  rst_n=~rst_n;
    end
always
    begin
       #25  clk_im=~clk_im;
    end
always
    begin
       #40  IR_Write=~IR_Write;
    end
always
    begin
       #30  PC_Write=~PC_Write;
    end
  zhilin ff(rst_n,IR_Write,PC_Write,clk_im,inst);
endmodule
