`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/08 20:57:01
// Design Name: 
// Module Name: CU
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


module CU(clk,rst_n,IS_R,IS_IMM,IS_LUI,ALU_OP_in,PC_Write,IR_Write,Reg_Write,rs2_imm_s,w_data_s,ALU_OP);
       input clk;
       input rst_n;
       input IS_R,IS_IMM,IS_LUI;
       input [3:0]ALU_OP_in;
       output reg PC_Write;
       output reg IR_Write;
       output reg Reg_Write;
       output reg rs2_imm_s;
       output reg w_data_s;
       output reg [3:0]ALU_OP;
       reg [2:0]ST;
       reg [2:0]Next_ST;
       parameter Idle=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101,S6=3'b110;
       //第一段：状态转移，在clk的边沿进行状态转移，是同步时序逻辑电路
       always@(negedge rst_n or posedge clk)
       begin
          if(!rst_n)//初始状态
            ST<=Idle;//初始状态
          else 
            ST<=Next_ST;//clk的上跳沿，进行状态转移
       end
       //第二段：次态函数，对次态的阻塞式赋值，是组合逻辑函数
       always@(*)
       begin
          Next_ST=Idle;
          case(ST) //根据状态转移图进行次态赋值
               Idle:Next_ST=S1;
               S1:begin
                       if(IS_LUI)Next_ST=S6;
                       else Next_ST=S2;
                  end
               S2:begin
                       if(IS_R)Next_ST=S3;
                       else Next_ST=S5;
                  end
               S3:begin
                       Next_ST=S4;
                  end
               S4:begin
                       Next_ST=S1;
                  end
               S5:begin
                       Next_ST=S4;
                  end
               S6:begin
                       Next_ST=S1;
                  end  
               default:Next_ST=S1;
          endcase
       end
       //第三段：输出函数，在clk的上跳沿，根据下一状态进行控制信号的非阻塞式赋值
       always@(negedge rst_n or posedge clk)
       begin
          if(!rst_n)    //全部信号初始化为0
          begin
             PC_Write<=1'b0;  IR_Write<=1'b0;  Reg_Write<=1'b0;
             ALU_OP<=4'b0000;  rs2_imm_s<=1'b0; w_data_s<=1'b0;
          end
          else
          begin
              case(Next_ST)
                  Idle:begin
                       PC_Write<=1'b0;  IR_Write<=1'b0;  Reg_Write<=1'b0;//初始状态
                       ALU_OP<=4'b0000;  rs2_imm_s<=1'b0; w_data_s<=1'b0;
                     end
                  S1:begin
                        PC_Write<=1'b1;  IR_Write<=1'b1;  Reg_Write<=1'b0;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0; w_data_s<=1'b0;  //下面三个无效，取任意值
                     end
                  S2:begin
                        PC_Write<=1'b0;  IR_Write<=1'b0;  Reg_Write<=1'b0;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0; w_data_s<=1'b0;  //下面三个无效，取任意值
                     end
                  S3:begin
                        PC_Write<=1'b0;  IR_Write<=1'b0;  Reg_Write<=1'b0;
                        ALU_OP<=ALU_OP_in;  rs2_imm_s<=1'b0; w_data_s<=1'b0;  //w_data_s无效，取任意值
                     end
                  S4:begin
                        PC_Write<=1'b0;  IR_Write<=1'b0;  Reg_Write<=1'b1;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0; w_data_s<=1'b0;  //ALU_OP,rs2_imm_s无效，取任意值
                     end
                  S5:begin
                        PC_Write<=1'b0;  IR_Write<=1'b0;  Reg_Write<=1'b0;
                        ALU_OP<=ALU_OP_in;  rs2_imm_s<=1'b1; w_data_s<=1'b0;  //w_data_s无效，取任意值
                     end
                  S6:begin
                        PC_Write<=1'b0;  IR_Write<=1'b0;  Reg_Write<=1'b1;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0; w_data_s<=1'b1;  //ALU_OP,rs2_imm_s无效，取任意值
                     end
           endcase
          end     
       end
endmodule
