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


module ALU(ALU_OP,ALU_A,ALU_B,ALU_F,ZF,SF,CF,OF); //ALU����ģ��
   input [3:0]ALU_OP;
   input [31:0]ALU_A;
   input [31:0]ALU_B;
   output [31:0]ALU_F;
   output  ZF;//�Ƿ�Ϊ0�����Ϊ0ʱ��ZF=1;����ZF=0
   output  SF;//���ű�־λ���������������λ��ͬ������ʱ��SF=0
   output  CF;//��λ/��λ�����λ�����Ľ�λC32���ӷ���C32=1ʱ��CF=1;������C32=0ʱ��CF=1  �޷���
   output  OF;//�����־λ���������OF=1��������
   reg [31:0]ALU_F;
   reg C32;//��߽�λ
   reg ZF,SF,CF,OF;
   always@(*)
   begin
      C32=0;
      case(ALU_OP)
            4'b0000:begin {C32,ALU_F}=ALU_A+ALU_B; end                      //�ӷ�
            4'b0001:begin ALU_F=ALU_A<<ALU_B; end                           //����
            4'b0010:begin ALU_F=($signed(ALU_A)<$signed(ALU_B))?1:0; end    //�з������Ƚ�  
            4'b0011:begin ALU_F=(ALU_A<ALU_B)?1:0; end                      //�޷������Ƚ�
            4'b0100:begin ALU_F=ALU_A^ALU_B; end                            //���
            4'b0101:begin ALU_F=ALU_A>>ALU_B; end                           //�߼����ƣ���λ����
            4'b0110:begin ALU_F=ALU_A|ALU_B; end                            //��λ��
            4'b0111:begin ALU_F=ALU_B&ALU_A; end                            //��λ��
            4'b1000:begin {C32,ALU_F}=ALU_A-ALU_B; end                      //����
            //4'b1101:begin ALU_F=ALU_A>>>ALU_B; end                          //�������ƣ���λ��ALU_A[31]   
            4'b1101:begin ALU_F=($signed(ALU_A))>>>ALU_B; end
      endcase 
       ZF = ALU_F==0;//FȫΪ0����ZF=1
       SF = ALU_F[31];//���ű�־,ȡF�����λ
       CF = C32; //��λ��λ��־
       OF = ALU_A[31]^ALU_B[31]^ALU_F[31]^C32;//�����־��ʽ  
   end
endmodule
