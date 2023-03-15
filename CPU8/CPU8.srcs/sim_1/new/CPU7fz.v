`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/15 22:10:16
// Design Name: 
// Module Name: CPU7fz
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


module CPU7fz();
//INPUT
reg clk;
reg rst_n;
reg [2:0]SW;
//OUTPUT
wire [3:0]FR;
wire [31:0]Choice;

initial
begin
   rst_n=0;clk=0;SW=3'b110;
   #25 rst_n=1;
end
always #50 clk=~clk;
CPU_D  ss(/*clk_1M,CLR,*/rst_n,clk,SW,FR,/*AN,seg*/Choice);
endmodule
