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
   wire  [3:0]secah;
   wire  [3:0]secal;
   wire  [3:0]secbh;
   wire  [3:0]secbl;
   wire  [1:0]state;
   fpq aa(CLR,clk_1M,CLK);
   jtd cc(CLK,CLR,start,stopa,stopb,pause,light,secah,secal,secbh,secbl,state);
   smgsm bb(CLK,CLR,secah,secal,secbh,secbl,AN,seg);
endmodule

module jtd(
   input CLK,    //时钟
   input CLR,   //系统复位
   input start, //交通灯正常启动
   input stopa, //主干道阻塞不通行
   input stopb, //次干道阻塞不通行
   input pause, //系统暂停
   output reg [5:0]light, //前三位主干道的三盏 红 黄 绿 LED 灯  后三位次干道的三盏 红 黄 绿 LED 灯  从左到右
   //output reg [7:0]seca,  //主干道读秒倒计时
   //output reg [7:0]secb,  //次干道读秒倒计时
   output reg [3:0]secah,  //主干道读秒倒计时十位
   output reg [3:0]secal,  //次干道读秒倒计时个位
   output reg [3:0]secbh,  //主干道读秒倒计时十位
   output reg [3:0]secbl,  //次干道读秒倒计时个位
   output reg [1:0]state //状态机
    );
	parameter s1=2'b00,s2=2'b01,s3=2'b10,s4=2'b11;// 四个循环状态			
always @(posedge CLK or posedge CLR)
begin
		   if(CLR) // 复位情况控制
				  begin
				     light<=6'b100100; //主从干道红灯亮
			         state<=s1; //数据管输出'----'
			         //seca<=8'b00000000;         //主干道读秒倒计时
                     //secb<=8'b00000000;         //次干道读秒倒计时
                     secah<=4'b0000;         //主干道读秒倒计时十位
                     secal<=4'b0000;         //主干道读秒倒计时个位
                     secbh<=4'b0000;         //次干道读秒倒计时十位
                     secbl<=4'b0000;         //次干道读秒倒计时个位
				  end
		    else if(stopa)
		       begin
		          light<=6'b100001; //主红次绿
		          state<=s3;
		          //seca<=8'bzzzzzzzz;         //主干道读秒倒计时
                  //secb<=8'bzzzzzzzz;         //次干道读秒倒计时
                  secah<=4'bzzzz;         //主干道读秒倒计时十位
                  secal<=4'bzzzz;         //主干道读秒倒计时个位
                  secbh<=4'bzzzz;         //次干道读秒倒计时十位
                  secbl<=4'bzzzz;         //次干道读秒倒计时个位
		       end 
			else if(stopb)
		       begin
		          light<=6'b001100; //主绿次红
		          state<=s1;
		         //seca<=8'bzzzzzzzz;         //主干道读秒倒计时
                 //secb<=8'bzzzzzzzz;         //次干道读秒倒计时
                 secah<=4'bzzzz;         //主干道读秒倒计时十位
                 secal<=4'bzzzz;         //主干道读秒倒计时个位
                 secbh<=4'bzzzz;         //次干道读秒倒计时十位
                 secbl<=4'bzzzz;         //次干道读秒倒计时个位
		       end
		    else if(start)
		       begin
		          case(state) //状态机	
						s1:begin 
						      light<=6'b001100;          //主绿次红
		                      //seca<=8'b00110101;         //主干道读秒倒计时35
                              //secb<=8'b00110101;         //次干道读秒倒计时35
                              secah<=4'b0011;         //主干道读秒倒计时十位3
                              secal<=4'b0101;         //主干道读秒倒计时个位5
                              secbh<=4'b0011;         //次干道读秒倒计时十位3
                              secbl<=4'b0101;         //次干道读秒倒计时个位5
                              if(pause)
                                 begin
                                    light<=6'b001100;          //主绿次红         
		                            //seca<=seca;         
                                    //secb<=secb;
                                    secah<=secah;         
                                    secal<=secal;         
                                    secbh<=secbh;         
                                    secbl<=secbl;         
                                 end
                              else
                                  begin
                                     /*if(seca>0&secb>0) 
                                        begin
                                             seca<=seca-1'b1;
                                             secb<=secb-1'b1;
                                        end*/
                                        if(secal>0&secbl>0)
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
                                            state<=s2;
                                  end
						   end
						s2:begin
						      light<=6'b010100;          //主黄次红
		                      //seca<=8'b00000101;         //主干道读秒倒计时5
                              //secb<=8'b00000101;         //次干道读秒倒计时5
                              secah<=4'b0000;         //主干道读秒倒计时十位0
                              secal<=4'b0101;         //主干道读秒倒计时个位5
                              secbh<=4'b0000;         //次干道读秒倒计时十位0
                              secbl<=4'b0101;         //次干道读秒倒计时个位5
                              if(pause)
                                 begin
                                    light<=6'b010100;          //主黄次红         
		                            //seca<=seca;         
                                    //secb<=secb;
                                    secah<=secah;         
                                    secal<=secal;         
                                    secbh<=secbh;         
                                    secbl<=secbl;  
                                 end
                              else
                                  begin
                                     /*if(seca>0&secb>0) 
                                        begin
                                             seca<=seca-1'b1;
                                             secb<=secb-1'b1;
                                        end*/
                                        if(secal>0&secbl>0)
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
                                            state<=s3;
                                  end
						   end
					    s3:begin
					          light<=6'b100001;           //主红次绿
		                      //seca<=8'b00100101;         //主干道读秒倒计时25
                              //secb<=8'b00100101;         //次干道读秒倒计时25
                              secah<=4'b0010;         //主干道读秒倒计时十位2
                              secal<=4'b0101;         //主干道读秒倒计时个位5
                              secbh<=4'b0010;         //次干道读秒倒计时十位2
                              secbl<=4'b0101;         //次干道读秒倒计时个位5
                              if(pause)
                                 begin
                                    light<=6'b100001;           //主红次绿         
		                            //seca<=seca;         
                                    //secb<=secb;
                                    secah<=secah;         
                                    secal<=secal;         
                                    secbh<=secbh;         
                                    secbl<=secbl;  
                                 end
                              else
                                  begin
                                     /*if(seca>0&secb>0) 
                                        begin
                                             seca<=seca-1'b1;
                                             secb<=secb-1'b1;
                                        end*/
                                      if(secal>0&secbl>0)
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
                                            state<=s4;
                                  end
						   end
				        s4:begin
				              light<=6'b100010;           //主红次黄
		                      //seca<=8'b00000101;         //主干道读秒倒计时5
                              //secb<=8'b00000101;         //次干道读秒倒计时5
                              secah<=4'b0000;         //主干道读秒倒计时十位0
                              secal<=4'b0101;         //主干道读秒倒计时个位5
                              secbh<=4'b0000;         //次干道读秒倒计时十位0
                              secbl<=4'b0101;         //次干道读秒倒计时个位5
                              if(pause)
                                 begin
                                    light<=6'b100010;           //主红次黄         
		                            //seca<=seca;         
                                    //secb<=secb; 
                                    secah<=secah;         
                                    secal<=secal;         
                                    secbh<=secbh;         
                                    secbl<=secbl; 
                                 end
                              else
                                  begin
                                     /*if(seca>0&secb>0) 
                                        begin
                                             seca<=seca-1'b1;
                                             secb<=secb-1'b1;
                                        end*/
                                      if(secal>0&secbl>0)
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
                                           state<=s1;
                                  end
						   end
						default:state<=s1;
			      endcase
		       end    
end
endmodule

module smgsm(
   input CLK, //扫描的间隔始终，控制数码管轮流点亮的频率
   input CLR, //复位信号，用于初始化状态
   input [3:0]secah,  //主干道读秒倒计时十位
   input [3:0]secal,  //次干道读秒倒计时个位
   input [3:0]secbh,  //主干道读秒倒计时十位
   input [3:0]secbl,  //次干道读秒倒计时个位
   output reg [3:0]AN,//位选
   output reg [7:0]seg //段选
    );
    reg [3:0] data;
    reg [1:0] bit_sel;  //数码管计数器指示，00~11 最左到最右
    always@(negedge CLR or posedge CLK)
    begin
       if(!CLR)
              bit_sel<=2'b00;   
       else
           bit_sel<=bit_sel+1'b1;
    end
    always@(*)
       begin
          case(bit_sel)
              2'b00:data<=secah;
              2'b01:data<=secal;
              2'b10:data<=secbh;
              2'b11:data<=secbl;
              default:data<=data;
          endcase
       end
    always@(*)
       begin
          case(bit_sel)
              2'b00:AN=4'b0111;
              2'b01:AN=4'b1011;
              2'b10:AN=4'b1101;
              2'b11:AN=4'b1110;
              default:AN=4'b1111;
          endcase
       end
    always@(*)
       begin
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
				default:seg<=8'b11111110;
          endcase
       end   
endmodule


module fpq(        //分频
  input CLR,
  input clk_1M,
  output reg CLK
    );
    reg [8:0]counter;
    always@(negedge CLR or posedge clk_1M)
    begin
      if(!CLR)
        begin
           counter<=9'd0;
           CLK<=1'b0;
        end
      else if(counter==9'd500)
            begin
               CLK<=~CLK;
               counter<=9'd0;
            end
      else
           counter<=counter+1'b1; 
    end
endmodule
