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


module CU(clk,rst_n,ZF,IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,IS_BEQ,IS_JAL,IS_JALR,ALU_OP_in,PC_Write,PC0_Write,IR_Write,Reg_Write,rs2_imm_s,w_data_s,Mem_Write,PC_s,ALU_OP);
       input clk;
       input rst_n;
       input ZF;
       input IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,IS_BEQ,IS_JAL,IS_JALR;
       input [3:0]ALU_OP_in;
       output reg PC_Write;
       output reg PC0_Write;
       output reg IR_Write;
       output reg Reg_Write;
       output reg rs2_imm_s;
       output reg [1:0]w_data_s;
       output  Mem_Write;
       output reg [1:0]PC_s;
       output reg [3:0]ALU_OP;
       reg [3:0]ST;
       reg [3:0]Next_ST;
       parameter Idle=4'b0000,S1=4'b0001,S2=4'b0010,S3=4'b0011,S4=4'b0100,S5=4'b0101,S6=4'b0110,S7=4'b0111,S8=4'b1000,S9=4'b1001,S10=4'b1010,S11=4'b1011,S12=4'b1100,S13=4'b1101,S14=4'b1110;
       //第一段：状态转移，在clk的边沿进行状态转移，是同步时序逻辑电路
       always@(negedge rst_n or posedge clk)
       begin
          if(!rst_n)//初始状态
            ST<=Idle;//初始状态
          else 
            ST<=Next_ST;//clk的上跳沿，进行状态转移
       end
       assign Mem_Write=(Next_ST==S10);
       //第二段：次态函数，对次态的阻塞式赋值，是组合逻辑函数
       always@(*)
       begin
          Next_ST=Idle;
          case(ST) //根据状态转移图进行次态赋值
               Idle:Next_ST=S1;
               S1:begin
                       if(IS_LUI)Next_ST=S6;
                       else if(IS_JAL)Next_ST=S11;
                       else Next_ST=S2;
                  end
               S2:begin
                       if(IS_R)Next_ST=S3;
                       else if(IS_IMM) Next_ST=S5;
                       else if(IS_BEQ) Next_ST=S13;
                       else Next_ST=S7;
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
               S7:begin
                       if(IS_LW) Next_ST=S8;
                       else if(IS_SW) begin Next_ST=S10;end
                       else Next_ST=S12;
                  end
               S8:begin
                       Next_ST=S9;
                  end
               S9:begin
                       Next_ST=S1;
                  end
               S10:begin
                       Next_ST=S1;
                  end
               S11:begin
                       Next_ST=S1;
                  end
               S12:begin
                       Next_ST=S1;
                  end
               S13:begin
                       Next_ST=S14;
                  end
               S14:begin
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
             PC_Write<=1'b0;   PC0_Write<=1'b0; IR_Write<=1'b0;   Reg_Write<=1'b0;
             ALU_OP<=4'b0000;  rs2_imm_s<=1'b0; w_data_s<=2'b00;  PC_s<=2'b00;
          end
          else
          begin
              case(Next_ST)
                  Idle:begin
                       PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b0; //初始状态
                       ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b00;  PC_s<=2'b00;
                     end
                  S1:begin
                        PC_Write<=1'b1;   PC0_Write<=1'b1;   IR_Write<=1'b1;   Reg_Write<=1'b0; 
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b00;  PC_s<=2'b00;//ALU_OP,rs2_imm_s,w_data_s无效，取任意值
                     end
                  S2:begin
                        PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b0; 
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b00;  PC_s<=2'b00;//下面4个都无效，取任意值
                     end
                  S3:begin
                        PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b0;
                        ALU_OP<=ALU_OP_in;  rs2_imm_s<=1'b0;  w_data_s<=2'b00;  PC_s<=2'b00;//w_data_s,PC_s无效，取任意值
                     end
                  S4:begin
                        PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b1;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b00;  PC_s<=2'b00;//ALU_OP,rs2_imm_s,PC_s无效，取任意值
                     end
                  S5:begin
                        PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b0;
                        ALU_OP<=ALU_OP_in;  rs2_imm_s<=1'b1;  w_data_s<=2'b00;  PC_s<=2'b00;//w_data_s,PC_s无效，取任意值
                     end
                  S6:begin
                        PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b1;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b01;  PC_s<=2'b00;//ALU_OP,rs2_imm_s,PC_s无效，取任意值
                     end
                  S7:begin
                        PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b0;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b1;  w_data_s<=2'b00;  PC_s<=2'b00;//w_data_s,PC_s无效，取任意值
                     end
                  S8:begin
                        PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b0;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b00;  PC_s<=2'b00;//下面4个都无效，取任意值
                     end
                  S9:begin
                        PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b1;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b10;  PC_s<=2'b00;//ALU_OP,rs2_imm_s,PC_s无效，取任意值
                     end
                  S10:begin
                        PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b0;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b00;  PC_s<=2'b00;//下面4个都无效，取任意值
                     end  
                  S11:begin
                        PC_Write<=1'b1;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b1;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b11;  PC_s<=2'b01;//ALU_OP,rs2_imm_s无效，取任意值
                     end  
                  S12:begin
                        PC_Write<=1'b1;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b1;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b11;  PC_s<=2'b10;//ALU_OP,rs2_imm_s无效，取任意值
                     end  
                  S13:begin
                        PC_Write<=1'b0;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b0;
                        ALU_OP<=4'b1000;  rs2_imm_s<=1'b0;  w_data_s<=2'b00;  PC_s<=2'b00;//w_data_s，PC_s无效，取任意值
                     end 
                  S14:begin
                        PC_Write<=ZF;   PC0_Write<=1'b0;   IR_Write<=1'b0;   Reg_Write<=1'b0;
                        ALU_OP<=4'b0000;  rs2_imm_s<=1'b0;  w_data_s<=2'b00;  PC_s<=2'b01;//ALU_OP,rs2_imm_s,w_data_s无效，取任意值
                     end   
           endcase
          end     
       end
endmodule
