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
module jiaotongdeng(clk_1M,CLR,start,stopa,stopb,pause,AN,seg,light); //����ģ��
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
   input CLK,    //ʱ��
   input CLR,   //ϵͳ��λ
   input start, //��ͨ����������
   input stopa, //���ɵ�������ͨ��
   input stopb, //�θɵ�������ͨ��
   input pause, //ϵͳ��ͣ
   output reg [5:0]light, //ǰ��λ���ɵ�����յ �� �� �� LED ��  ����λ�θɵ�����յ �� �� �� LED ��  ������
   //output reg [7:0]seca,  //���ɵ����뵹��ʱ
   //output reg [7:0]secb,  //�θɵ����뵹��ʱ
   output reg [3:0]secah,  //���ɵ����뵹��ʱʮλ
   output reg [3:0]secal,  //�θɵ����뵹��ʱ��λ
   output reg [3:0]secbh,  //���ɵ����뵹��ʱʮλ
   output reg [3:0]secbl,  //�θɵ����뵹��ʱ��λ
   output reg [1:0]state //״̬��
    );
	parameter s1=2'b00,s2=2'b01,s3=2'b10,s4=2'b11;// �ĸ�ѭ��״̬			
always @(posedge CLK or posedge CLR)
begin
		   if(CLR) // ��λ�������
				  begin
				     light<=6'b100100; //���Ӹɵ������
			         state<=s1; //���ݹ����'----'
			         //seca<=8'b00000000;         //���ɵ����뵹��ʱ
                     //secb<=8'b00000000;         //�θɵ����뵹��ʱ
                     secah<=4'b0000;         //���ɵ����뵹��ʱʮλ
                     secal<=4'b0000;         //���ɵ����뵹��ʱ��λ
                     secbh<=4'b0000;         //�θɵ����뵹��ʱʮλ
                     secbl<=4'b0000;         //�θɵ����뵹��ʱ��λ
				  end
		    else if(stopa)
		       begin
		          light<=6'b100001; //�������
		          state<=s3;
		          //seca<=8'bzzzzzzzz;         //���ɵ����뵹��ʱ
                  //secb<=8'bzzzzzzzz;         //�θɵ����뵹��ʱ
                  secah<=4'bzzzz;         //���ɵ����뵹��ʱʮλ
                  secal<=4'bzzzz;         //���ɵ����뵹��ʱ��λ
                  secbh<=4'bzzzz;         //�θɵ����뵹��ʱʮλ
                  secbl<=4'bzzzz;         //�θɵ����뵹��ʱ��λ
		       end 
			else if(stopb)
		       begin
		          light<=6'b001100; //���̴κ�
		          state<=s1;
		         //seca<=8'bzzzzzzzz;         //���ɵ����뵹��ʱ
                 //secb<=8'bzzzzzzzz;         //�θɵ����뵹��ʱ
                 secah<=4'bzzzz;         //���ɵ����뵹��ʱʮλ
                 secal<=4'bzzzz;         //���ɵ����뵹��ʱ��λ
                 secbh<=4'bzzzz;         //�θɵ����뵹��ʱʮλ
                 secbl<=4'bzzzz;         //�θɵ����뵹��ʱ��λ
		       end
		    else if(start)
		       begin
		          case(state) //״̬��	
						s1:begin 
						      light<=6'b001100;          //���̴κ�
		                      //seca<=8'b00110101;         //���ɵ����뵹��ʱ35
                              //secb<=8'b00110101;         //�θɵ����뵹��ʱ35
                              secah<=4'b0011;         //���ɵ����뵹��ʱʮλ3
                              secal<=4'b0101;         //���ɵ����뵹��ʱ��λ5
                              secbh<=4'b0011;         //�θɵ����뵹��ʱʮλ3
                              secbl<=4'b0101;         //�θɵ����뵹��ʱ��λ5
                              if(pause)
                                 begin
                                    light<=6'b001100;          //���̴κ�         
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
						      light<=6'b010100;          //���ƴκ�
		                      //seca<=8'b00000101;         //���ɵ����뵹��ʱ5
                              //secb<=8'b00000101;         //�θɵ����뵹��ʱ5
                              secah<=4'b0000;         //���ɵ����뵹��ʱʮλ0
                              secal<=4'b0101;         //���ɵ����뵹��ʱ��λ5
                              secbh<=4'b0000;         //�θɵ����뵹��ʱʮλ0
                              secbl<=4'b0101;         //�θɵ����뵹��ʱ��λ5
                              if(pause)
                                 begin
                                    light<=6'b010100;          //���ƴκ�         
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
					          light<=6'b100001;           //�������
		                      //seca<=8'b00100101;         //���ɵ����뵹��ʱ25
                              //secb<=8'b00100101;         //�θɵ����뵹��ʱ25
                              secah<=4'b0010;         //���ɵ����뵹��ʱʮλ2
                              secal<=4'b0101;         //���ɵ����뵹��ʱ��λ5
                              secbh<=4'b0010;         //�θɵ����뵹��ʱʮλ2
                              secbl<=4'b0101;         //�θɵ����뵹��ʱ��λ5
                              if(pause)
                                 begin
                                    light<=6'b100001;           //�������         
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
				              light<=6'b100010;           //����λ�
		                      //seca<=8'b00000101;         //���ɵ����뵹��ʱ5
                              //secb<=8'b00000101;         //�θɵ����뵹��ʱ5
                              secah<=4'b0000;         //���ɵ����뵹��ʱʮλ0
                              secal<=4'b0101;         //���ɵ����뵹��ʱ��λ5
                              secbh<=4'b0000;         //�θɵ����뵹��ʱʮλ0
                              secbl<=4'b0101;         //�θɵ����뵹��ʱ��λ5
                              if(pause)
                                 begin
                                    light<=6'b100010;           //����λ�         
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
   input CLK, //ɨ��ļ��ʼ�գ��������������������Ƶ��
   input CLR, //��λ�źţ����ڳ�ʼ��״̬
   input [3:0]secah,  //���ɵ����뵹��ʱʮλ
   input [3:0]secal,  //�θɵ����뵹��ʱ��λ
   input [3:0]secbh,  //���ɵ����뵹��ʱʮλ
   input [3:0]secbl,  //�θɵ����뵹��ʱ��λ
   output reg [3:0]AN,//λѡ
   output reg [7:0]seg //��ѡ
    );
    reg [3:0] data;
    reg [1:0] bit_sel;  //����ܼ�����ָʾ��00~11 ��������
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


module fpq(        //��Ƶ
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
