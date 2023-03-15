`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/27 16:15:34
// Design Name: 
// Module Name: shjfz
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


module shjfz;
//INPUT
reg [1:0] key; //投币按钮
reg clk; //计时器
reg rst; //重置交易记录和数码管显示
reg deal; //交易按钮
reg [2:0]sel_goods; // 用来选择商品 001代表可乐 011代表红茶 100代表乌龙茶
reg goods_num_query; //库存查询
//OUTPUT
wire [6:0] a_to_g; //数码管数字显示
wire [3:0] an; //用来点亮数码管
wire disp_dot; //小数点
wire [7:0] led;//灯光效果！
main ni(key, clk, rst, a_to_g, an, sel_goods, deal, goods_num_query, disp_dot, led);
initial 
     begin
		A = 0;B = 0;C = 0;D = 0;E = 0;
		#100;
endmodule
