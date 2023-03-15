`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/13 22:27:11
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
            4'b0010:begin ALU_F=($signed(ALU_A)<$signed(ALU_B))?1:0; end    //有符号数比较  
            4'b0011:begin ALU_F=(ALU_A<ALU_B)?1:0; end                      //无符号数比较
            4'b0100:begin ALU_F=ALU_A^ALU_B; end                            //异或
            4'b0101:begin ALU_F=ALU_A>>ALU_B; end                           //逻辑右移，高位补零
            4'b0110:begin ALU_F=ALU_A|ALU_B; end                            //按位或
            4'b0111:begin ALU_F=ALU_B&ALU_A; end                            //按位与
            4'b1000:begin {C32,ALU_F}=ALU_A-ALU_B; end                      //减法
            //4'b1101:begin ALU_F=ALU_A>>>ALU_B; end                          //算术右移，高位补ALU_A[31]   
            4'b1101:begin ALU_F=($signed(ALU_A))>>>ALU_B; end
      endcase 
       ZF = ALU_F==0;//F全为0，则ZF=1
       SF = ALU_F[31];//符号标志,取F的最高位
       CF = C32; //进位借位标志
       OF = ALU_A[31]^ALU_B[31]^ALU_F[31]^C32;//溢出标志公式  
   end
endmodule
