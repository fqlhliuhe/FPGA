`timescale 10ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 20:55:13
// Design Name: 
// Module Name: jtdfz
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


module jtdfz;
//INPUT
reg CLK;    //ʱ��
reg CLR;   //ϵͳ��λ
reg start; //��ͨ����������
reg stopa; //���ɵ�������ͨ��
reg stopb; //�θɵ�������ͨ��
reg pause; //ϵͳ��ͣ
 //OUTPUT
wire [5:0]light; //ǰ��λ���ɵ�����յ �� �� �� LED ��  ����λ�θɵ�����յ �� �� �� LED ��  ������
//wire [7:0]seca;  //���ɵ����뵹��ʱ
//wire [7:0]secb;  //�θɵ����뵹��ʱ
wire[3:0]secah;  //���ɵ����뵹��ʱʮλ
wire[3:0]secal;  //�θɵ����뵹��ʱ��λ
wire[3:0]secbh; //���ɵ����뵹��ʱʮλ
wire[3:0]secbl; //�θɵ����뵹��ʱ��λ
wire [1:0]state; //״̬��
initial
     begin
        CLK=0;CLR=0;start=1;stopa=0;stopb=0;pause=0;       
	  end
always
     begin
        #10 CLK=~CLK;
     end
always
     begin
        #2000 CLR=~CLR;
     end
always
     begin
        #800 start=~start;
     end
 always
     begin
        #1000 stopa=~stopa;
     end
 always
     begin
        #1500 stopb=~stopb;
     end
 always
     begin
        #100 pause=~pause;
     end
 jtd ha(CLK,CLR,start,stopa,stopb,pause,light,secah,secal,secbh,secbl,state);     
endmodule
