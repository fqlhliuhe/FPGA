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
reg [1:0] key; //Ͷ�Ұ�ť
reg clk; //��ʱ��
reg rst; //���ý��׼�¼���������ʾ
reg deal; //���װ�ť
reg [2:0]sel_goods; // ����ѡ����Ʒ 001������� 011������ 100����������
reg goods_num_query; //����ѯ
//OUTPUT
wire [6:0] a_to_g; //�����������ʾ
wire [3:0] an; //�������������
wire disp_dot; //С����
wire [7:0] led;//�ƹ�Ч����
main ni(key, clk, rst, a_to_g, an, sel_goods, deal, goods_num_query, disp_dot, led);
initial 
     begin
		A = 0;B = 0;C = 0;D = 0;E = 0;
		#100;
endmodule
