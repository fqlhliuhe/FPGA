`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 08:10:30
// Design Name: 
// Module Name: ajxdfz
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


module ajxdfz;
//INPUT
reg rst;
reg clk;
reg key;  
//OUTPUT
wire key_pulse;
ajxd si(rst,clk,key,key_pulse);
always #10   clk = ~clk;
always #100  rst=~rst;
always #20   key= ~key;
	initial 
	   begin
		clk = 1'b0;
		rst = 1'b0;
		key = 1'b1;
	end
endmodule
