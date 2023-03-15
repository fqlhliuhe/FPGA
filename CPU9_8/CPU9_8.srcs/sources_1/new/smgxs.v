`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/01 08:44:20
// Design Name: 
// Module Name: smgxs
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