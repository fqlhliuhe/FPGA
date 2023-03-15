`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/27 16:57:12
// Design Name: 
// Module Name: jtd
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
module jiaotongdeng(clk_1M,CLR,start,stopa,stopb,pause,AN,seg,light); //顶层模块
   input clk_1M;
   input CLR;
   input start;
   input stopa;
   input stopb;
   input pause;
   output  [3:0]AN;
   output  [7:0]seg;
   output  [5:0]light;
   wire CLK;
   wire clk;
   wire  [3:0]secah;
   wire  [3:0]secal;
   wire  [3:0]secbh;
   wire  [3:0]secbl;
   wire  [1:0]state;
   fpq2 aa(clk_1M,CLK);
   jtd cc(CLK,CLR,start,stopa,stopb,pause,light,secah,secal,secbh,secbl,state);
   fpq1 dd(clk_1M,clk);
   smgsm bb(clk,secah,secal,secbh,secbl,AN,seg);
endmodule

module jtd(
   input CLK,    //时钟
   input CLR,   //系统复位
   input start, //交通灯正常启动
   input stopa, //主干道阻塞不通行
   input stopb, //次干道阻塞不通行
   input pause, //系统暂停
   output reg [5:0]light, //前三位主干道的三盏 红 黄 绿 LED 灯  后三位次干道的三盏 红 黄 绿 LED 灯  从左到右
   output reg [3:0]secah,  //主干道读秒倒计时十位
   output reg [3:0]secal,  //主干道读秒倒计时个位
   output reg [3:0]secbh,  //次干道读秒倒计时十位
   output reg [3:0]secbl,  //次干道读秒倒计时个位
   output reg [1:0]state //状态机
    );
	parameter s1=2'b00,s2=2'b01,s3=2'b10,s4=2'b11;// 四个循环状态			
always @(posedge CLK or posedge CLR)
begin
           //state=s1;
		   if(CLR) // 复位情况控制
				  begin      
                     secah<=4'b0000;         //主干道读秒倒计时十位
                     secal<=4'b0000;         //主干道读秒倒计时个位
                     secbh<=4'b0000;         //次干道读秒倒计时十位
                     secbl<=4'b0000;         //次干道读秒倒计时个位
                     state<=s1; 
				  end
		    else if(stopa)
		       begin
		          state<=s3;
                  secah<=4'bzzzz;         //主干道读秒倒计时十位
                  secal<=4'bzzzz;         //主干道读秒倒计时个位
                  secbh<=4'bzzzz;         //次干道读秒倒计时十位
                  secbl<=4'bzzzz;         //次干道读秒倒计时个位
		       end 
			else if(stopb)
		       begin
		         state<=s1;
                 secah<=4'bzzzz;         //主干道读秒倒计时十位
                 secal<=4'bzzzz;         //主干道读秒倒计时个位
                 secbh<=4'bzzzz;         //次干道读秒倒计时十位
                 secbl<=4'bzzzz;         //次干道读秒倒计时个位
		       end
		    else if(pause==0&start)
		       begin
		          case(state) //状态机	
						s1:begin 
                              secah<=4'b0011;         //主干道读秒倒计时十位3
                              secal<=4'b0101;         //主干道读秒倒计时个位5
                              secbh<=4'b0011;         //次干道读秒倒计时十位3
                              secbl<=4'b0101;         //次干道读秒倒计时个位5    
                                        if(secah!=0&secbh!=0&secal==0&secbl==0)
                                            begin
                                              secah<=secah-1'b1;         
                                              secal<=4'b1001;         
                                              secbh<=secbh-1'b1;         
                                              secbl<=4'b1001;
                                            end
                                        if(secal>0&secbl>0)
                                           begin
                                              secah<=secah;         
                                              secal<=secal-1'b1;         
                                              secbh<=secbh;         
                                              secbl<=secbl-1'b1;
                                           end
                                        else
                                            begin
                                            if(secah==0&secal==0&secbh==0&secbl==0)
                                            state<=s2;
                                            end
                                  end
						s2:begin
                              secah<=4'b0000;         //主干道读秒倒计时十位0
                              secal<=4'b0101;         //主干道读秒倒计时个位5
                              secbh<=4'b0000;         //次干道读秒倒计时十位0
                              secbl<=4'b0101;         //次干道读秒倒计时个位5
                                        if(secah!=0&secbh!=0&secal==0&secbl==0)
                                            begin
                                              secah<=secah-1'b1;         
                                              secal<=4'b1001;         
                                              secbh<=secbh-1'b1;         
                                              secbl<=4'b1001;
                                            end
                                        else if(secal>0&secbl>0)
                                           begin
                                              secah<=secah;         
                                              secal<=secal-1'b1;         
                                              secbh<=secbh;         
                                              secbl<=secbl-1'b1;  
                                           end
                                        else if(secah!=0&secbh!=0&secal==0&secbl==0)
                                            begin
                                              secah<=secah-1'b1;         
                                              secal<=4'b1001;         
                                              secbh<=secbh-1'b1;         
                                              secbl<=4'b1001;
                                            end
                                         else
                                            begin
                                            if(secah==0&secal==0)
                                            state<=s3;
                                            end
                                  end
					    s3:begin
                              secah<=4'b0010;         //主干道读秒倒计时十位2
                              secal<=4'b0101;         //主干道读秒倒计时个位5
                              secbh<=4'b0010;         //次干道读秒倒计时十位2
                              secbl<=4'b0101;         //次干道读秒倒计时个位5
                                      if(secah!=0&secbh!=0&secal==0&secbl==0)
                                            begin
                                              secah<=secah-1'b1;         
                                              secal<=4'b1001;         
                                              secbh<=secbh-1'b1;         
                                              secbl<=4'b1001;
                                            end
                                      else if(secal>0&secbl>0)
                                           begin
                                              secah<=secah;         
                                              secal<=secal-1'b1;         
                                              secbh<=secbh;         
                                              secbl<=secbl-1'b1;  
                                           end
                                         else
                                            if(secah==0&secal==0)
                                            state<=s4;
                                  end
				        s4:begin
                              secah<=4'b0000;         //主干道读秒倒计时十位0
                              secal<=4'b0101;         //主干道读秒倒计时个位5
                              secbh<=4'b0000;         //次干道读秒倒计时十位0
                              secbl<=4'b0101;         //次干道读秒倒计时个位5
                                     if(secah!=0&secbh!=0&secal==0&secbl==0)
                                            begin
                                              secah<=secah-1'b1;         
                                              secal<=4'b1001;         
                                              secbh<=secbh-1'b1;         
                                              secbl<=4'b1001;
                                            end
                                      else if(secal>0&secbl>0)
                                           begin
                                              secah<=secah;         
                                              secal<=secal-1'b1;         
                                              secbh<=secbh;         
                                              secbl<=secbl-1'b1;  
                                           end
                                         else
                                           begin
                                           if(secah==0&secal==0)
                                              state<=s1;
                                           end
                                  end
						default:state<=s1;
			      endcase
		       end    
		    else
		       begin
		          if(pause)
                         begin
                              light<=light;            
                              secah<=secah;         
                              secal<=secal;         
                              secbh<=secbh;         
                              secbl<=secbl;         
                         end
		       end
end
always@(*)
begin
    if(CLR)
      light<=6'b100100; //主从干道红灯亮
    else if(stopa)
      light<=6'b100001; //主红次绿
    else if(stopb)
      light<=6'b001100; //主绿次红
    else
    begin 
       if(start)
           begin
              case(state)
                     s1:light<=6'b001100;  //主绿次红
                     s2:light<=6'b010100;  //主黄次红
                     s3:light<=6'b100001;  //主红次绿
                     s4:light<=6'b100010;  //主红次黄
                     default:light<=6'b000000;
               endcase 
            end
    end        
end
endmodule

module smgsm(
   input CLK, //扫描的间隔始终，控制数码管轮流点亮的频率
   input [3:0]secah,  //主干道读秒倒计时十位
   input [3:0]secal,  //次干道读秒倒计时个位
   input [3:0]secbh,  //主干道读秒倒计时十位
   input [3:0]secbl,  //次干道读秒倒计时个位
   output reg [3:0]AN,//位选
   output reg [7:0]seg //段选
    );
    reg [3:0] data;
    reg [1:0] bit_sel;  //数码管计数器指示，00~11 最左到最右
  initial
         begin     
              bit_sel<=2'b00;   
         end
    always@(posedge CLK)
       begin
          bit_sel<=bit_sel+1'b1;        
          case(bit_sel)
              2'b00:begin data<=secah;AN=4'b0111; end
              2'b01:begin data<=secal;AN=4'b1011; end
              2'b10:begin data<=secbh;AN=4'b1101;end
              2'b11:begin data<=secbl;AN=4'b1110;end
              default:begin data<=data;AN=4'b1111;end
          endcase
          
          case(data)
                0:seg<=8'b00000011;
				1:seg<=8'b10011111;
				2:seg<=8'b00100101;
				3:seg<=8'b00001101;
				4:seg<=8'b10011001;
				5:seg<=8'b01001001;
				6:seg<=8'b01000001;
				7:seg<=8'b00011111;
				8:seg<=8'b00000001;
				9:seg<=8'b00001001;
				default:seg<=8'b11111111;
          endcase
      end
endmodule


module fpq1(        //分频 数码管扫描
  input clk_1M,
  output reg clk
    );
    reg [31:0]counter;
    initial
        begin
           counter<=31'd0;
           clk<=1'b0;
        end
    always@(posedge clk_1M)
    begin
      if(counter==31'd2000)
            begin
               clk<=~clk;
               counter<=31'd0;
            end
      else
           counter<=counter+1'b1; 
    end
endmodule

module fpq2(        //分频 交通灯倒计时
  input clk_1M,
  output reg CLK
    );
    reg [31:0]counter;
    initial
        begin
           counter<=31'd0;
           CLK<=1'b0;
        end
    always@(posedge clk_1M)
    begin
      if(counter==31'd50000000)
            begin
               CLK<=~CLK;
               counter<=31'd0;
            end
      else
           counter<=counter+1'b1; 
    end
endmodule

