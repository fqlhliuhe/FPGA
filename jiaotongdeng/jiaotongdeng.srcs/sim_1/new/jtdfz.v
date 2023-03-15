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
reg CLK;    //时钟
reg CLR;   //系统复位
reg start; //交通灯正常启动
reg stopa; //主干道阻塞不通行
reg stopb; //次干道阻塞不通行
reg pause; //系统暂停
 //OUTPUT
wire [5:0]light; //前三位主干道的三盏 红 黄 绿 LED 灯  后三位次干道的三盏 红 黄 绿 LED 灯  从左到右
//wire [7:0]seca;  //主干道读秒倒计时
//wire [7:0]secb;  //次干道读秒倒计时
wire[3:0]secah;  //主干道读秒倒计时十位
wire[3:0]secal;  //次干道读秒倒计时个位
wire[3:0]secbh; //主干道读秒倒计时十位
wire[3:0]secbl; //次干道读秒倒计时个位
wire [1:0]state; //状态机
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
