`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/10 19:55:10
// Design Name: 
// Module Name: ALU
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


module dingceng(R_Data_A,R_Data_B,clk_1M,CLR,rst_n,clk_RR,clk_F,ALU_OP,choose,F,FR,AN,seg);//顶层模块
  input [31:0]R_Data_A;
  input [31:0]R_Data_B;
  input clk_1M;
  input CLR;
  input rst_n;
  input clk_RR;
  input clk_F;
  input [3:0]ALU_OP;
  input [1:0]choose;
  output [3:0]FR;
  output [7:0]AN;
  output [7:0]seg;
  wire CLK;
  wire [31:0]ALU_A;
  wire [31:0]ALU_B;
  wire [31:0]ALU_F;
  output [31:0]F;
  wire [31:0]Choice;
  wire ZF,SF,CF,OF;
  zcA aa(rst_n,R_Data_A,clk_RR,ALU_A);
  zcB bb(rst_n,R_Data_B,clk_RR,ALU_B);
  ALU cc(ALU_OP,ALU_A,ALU_B,ALU_F,ZF,SF,CF,OF); 
  zcF dd(rst_n,ALU_F,clk_F,F);
  jcqFR ee(clk_F,rst_n,ZF,SF,CF,OF,FR);
  fpq gg(CLR,clk_1M,CLK);
  threeone kk(choose,ALU_A,ALU_B,F,Choice);
  smgsm ff(CLK,CLR,Choice,AN,seg);
endmodule
 
module threeone(Out_Sel,ALU_A,ALU_B,F,Choice);//三选一A,B,F输出到数码管显示
   input [1:0]Out_Sel;
   input [31:0]ALU_A;
   input [31:0]ALU_B;
   input [31:0]F;
   output reg [31:0]Choice;
   always@(*)
   begin
       case(Out_Sel)
              2'b00:begin Choice=F; end
              2'b01:begin Choice=ALU_A; end
              2'b10:begin Choice=ALU_B; end
              default:begin Choice=F; end  
       endcase
   end
endmodule

module zcA(rst_n,Data_A,clk_A,ALU_A);//A暂存器
   input rst_n;
   input [31:0]Data_A;
   input clk_A;
   output reg [31:0]ALU_A;
   always@(negedge rst_n or posedge clk_A)
   begin 
      if(!rst_n)
         ALU_A<=32'b0;
      else
         ALU_A<=Data_A;
   end
endmodule

module zcB(rst_n,Data_B,clk_B,ALU_B);//B暂存器
   input rst_n;
   input [31:0]Data_B;
   input clk_B;
   output reg [31:0]ALU_B;
   always@(negedge rst_n or posedge clk_B)
   begin 
      if(!rst_n)
         ALU_B<=32'b0;
      else
         ALU_B<=Data_B;
   end
endmodule

module zcF(rst_n,ALU_F,clk_F,F);//F暂存器
   input rst_n;
   input [31:0]ALU_F;
   input clk_F;
   output reg [31:0]F;
   always@(negedge rst_n or posedge clk_F)
   begin 
      if(!rst_n)
         F<=32'b0;
      else
         F<=ALU_F;
   end
endmodule  

module jcqFR(clk_F,rst_n,ZF,SF,CF,OF,FR);//FR标志寄存器
   input clk_F;
   input rst_n;
   input ZF,SF,CF,OF;
   output reg [3:0]FR;
   always@(negedge rst_n or posedge clk_F)
   begin 
      if(!rst_n)
         FR<=4'b0;
      else
         begin
            FR[3]=ZF;
            FR[2]=SF;
            FR[1]=CF;
            FR[0]=OF;
         end
   end
endmodule

module ALU(ALU_OP,ALU_A,ALU_B,ALU_F,ZF,SF,CF,OF); //ALU功能模块
   input [3:0]ALU_OP;
   input [31:0]ALU_A;
   input [31:0]ALU_B;
   output [31:0]ALU_F;
   output  ZF;//是否为0，结果为0时，ZF=1;否则，ZF=0
   output  SF;//符号标志位，与运算结果的最高位相同，正数时，SF=0
   output  CF;//进位/借位，最高位产生的进位C32，加法：C32=1时，CF=1;减法：C32=0时，CF=1  无符号
   output  OF;//溢出标志位，有溢出，OF=1；带符号
   reg [31:0]ALU_F;
   reg C32;//最高进位
   reg ZF,SF,CF,OF;
   always@(*)
   begin
      C32=0;
      case(ALU_OP)
            4'b0000:begin {C32,ALU_F}=ALU_A+ALU_B; end                      //加法
            4'b0001:begin ALU_F=ALU_A<<ALU_B; end                           //左移
            4'b0010:begin ALU_F=($signed(ALU_A)<$signed(ALU_B))?1:0; end    //有符号数比较  有问题
            4'b0011:begin ALU_F=(ALU_A<ALU_B)?1:0; end                      //无符号数比较
            4'b0100:begin ALU_F=ALU_A^ALU_B; end                            //异或
            4'b0101:begin ALU_F=ALU_A>>ALU_B; end                           //逻辑右移，高位补零
            4'b0110:begin ALU_F=ALU_A|ALU_B; end                            //按位或
            4'b0111:begin ALU_F=ALU_B&ALU_A; end                            //按位与
            4'b1000:begin {C32,ALU_F}=ALU_A-ALU_B; end                      //减法
            //4'b1101:begin ALU_F=ALU_A>>>ALU_B; end                          //算术右移，高位补ALU_A[31]   有问题
            4'b1101:begin ALU_F=($signed(ALU_A))>>>ALU_B; end
      endcase 
       ZF = ALU_F==0;//F全为0，则ZF=1
       SF = ALU_F[31];//符号标志,取F的最高位
       CF = C32; //进位借位标志
       OF = ALU_A[31]^ALU_B[31]^ALU_F[31]^C32;//溢出标志公式  
   end
endmodule

module fpq(CLR,clk_1M,CLK);        //分频器模块
  input CLR;
  input clk_1M;
  output reg CLK;
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

module smgsm(CLK,CLR,Choice,AN,seg);//数码管扫描显示模块
    input CLK; //扫描的间隔始终，控制数码管轮流点亮的频率
    input CLR; //复位信号，用于初始化状态
    input[31:0]Choice;
    output reg [7:0]AN;//位选
    output reg [7:0]seg; //段选
    reg [3:0] data;
    reg [2:0] bit_sel;  //数码管计数器指示，000~111 最左到最右
    always@(negedge CLR or posedge CLK)
    begin
       if(!CLR)
              bit_sel<=3'b000;   
       else
           bit_sel<=bit_sel+1'b1;
    end
    always@(*)
       begin
          case(bit_sel)
              3'b000:data<=Choice[3:0];
              3'b001:data<=Choice[7:4];
              3'b010:data<=Choice[11:8];
              3'b011:data<=Choice[15:12];
              3'b100:data<=Choice[19:16];
              3'b101:data<=Choice[23:20];
              3'b110:data<=Choice[27:24];
              3'b111:data<=Choice[31:28];
              default:data<=data;
          endcase
       end
    always@(*)
       begin
          case(bit_sel)
              3'b000:AN=8'b11111110;
              3'b001:AN=8'b11111101;
              3'b010:AN=8'b11111011;
              3'b011:AN=8'b11110111;
              3'b100:AN=8'b11101111;
              3'b101:AN=8'b11011111;
              3'b110:AN=8'b10111111;
              3'b111:AN=8'b01111111;
              default:AN=8'b11111111;
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
                   10:seg<=8'b00010001;
                   11:seg<=8'b11000001;
                   12:seg<=8'b01100011;
                   13:seg<=8'b10000101;
                   14:seg<=8'b01100001;
                   15:seg<=8'b01110001;
				default:seg<=8'b11111111;
          endcase
       end   
endmodule
