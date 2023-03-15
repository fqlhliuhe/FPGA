`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/23 18:25:41
// Design Name: 
// Module Name: zdshj
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


/*module zdshj( //自动售货机
     input CLK,//时钟
     input CLR,//系统复位
     input [7:0] k,//拨码开关
     input seortbt,//补货/投币按钮
     input get,//购买按钮
     input [1:0]sel,//选择商品种类按钮
     input finish,//退币按扭
     output [7:0] seg, //数码管数字显示
     output reg [3:0] AN //用来点亮数码管
    );
      reg [1:0] kind;//商品种类
      reg [2:0] price;//商品单价
      reg [3:0] remain;//商品的库存数量
      reg [3:0] num;//本次购买该种商品的数量
      reg [51:0] Data;//商品种类，单价，库存数量,【3：0】Data本次购买该种商品的数量
    always@(posedge CLK)
    begin
       if(!k[7])  begin shoumai(); end
       else      begin  buhuo(CLK,sel,k,Data); end
    end
endmodule*/



module buhuo(//补货
     input CLK,//时钟
     input CLR,//系统复位
     input [7:0] k,//拨码开关
     input seortbt,//补货/投币按钮
     //input get,//购买按钮
     input [1:0]sel,//选择商品种类按钮
     //input finish,//退币按扭
     output [7:0] seg, //数码管数字显示
     output reg [3:0] AN //用来点亮数码管
);
 reg [51:0] data;
   //=========================商品选择=============================================
//0001代表可乐1 
//0010代表红茶2 
//0100代表乌龙茶4 
//1000代表雪碧8 ;
 always @(posedge CLK or posedge seortbt)
        begin
          case(sel)
             1:begin data[0:3]=sel[1:0];   data[4:7]=k[6:4];    data[8:11]=k[3:0];  end
             2:begin data[12:15]=sel[1:0]; data[16:19]=k[6:4];  data[20:23]=k[3:0]; end
             3:begin data[24:27]=sel[1:0]; data[28:31]=k[6:4];  data[32:35]=k[3:0]; end
             4:begin data[36:39]=sel[1:0]; data[40:43]=k[6:4];  data[44:47]=k[3:0]; end
             default:data[48:51] = 4'b0000; 
           endcase
         end

  smgsm see(CLK,CLR,sel,data,AN,seg);
  
endmodule


module smgsm(  //数码管扫描
   input clk_ref,
   input rst_,
   input [1:0] kind,
   input [51:0]Data,
   output reg [3:0]AN,
   output reg [7:0]seg
    );
    reg [1:0] bit_sel;
    reg [11:0] data_x;
   always@(negedge rst_ or posedge clk_ref)
    begin
       if(!rst_)
              bit_sel<=2'b0;   
       else
           bit_sel<=bit_sel+1'b1;
    end
    always@(*)
       begin
          case(kind)
              2'b00:data_x<=Data[0:11];
              2'b01:data_x<=Data[12:23];
              2'b10:data_x<=Data[24:35];
              2'b11:data_x<=Data[36:47];
              default:data_x<=Data[48:51];
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
          case(data_x)
                4'b0000:seg<=8'b00000011;  //0
				4'b0001:seg<=8'b10011111;  //1
				4'b0010:seg<=8'b00100101;  //2
				4'b0011:seg<=8'b00001101;  //3
				4'b0100:seg<=8'b10011001;  //4
				4'b0101:seg<=8'b01001001;  //5
				4'b0110:seg<=8'b01000001;  //6
				4'b0111:seg<=8'b00011111;  //7
				4'b1000:seg<=8'b00000001;  //8
				4'b1001:seg<=8'b00001001;  //9
				4'b1010:seg<=8'b00010001;  //10,A
				4'b1011:seg<=8'b11000001;  //11,B
				4'b1100:seg<=8'b01100011;  //12,C
				4'b1101:seg<=8'b10000101;  //13,D
				4'b1110:seg<=8'b01100001;  //14,E
				4'b1111:seg<=8'b01110001;  //15,F
				default:seg<=8'b11111111;
          endcase
       end
endmodule