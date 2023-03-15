`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 19:52:36
// Design Name: 
// Module Name: smgsm
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


module smgsm(
   input clk_ref,
   input rst_,
   output [7:0]AN,
   output [7:0]SEG
    );
    reg [31:0] Data;
    reg [2:0] BIT_SEL;
    reg [3:0] data_x; 
    always@(negedge rst_ or posedge clk_ref)
    begin
       if(!rst_)
              BIT_SEL<=3'b0;   
       else
           BIT_SEL<=BIT_SEL+1'b1;
    end
    always@(*)
       begin
          case(BIT_SEL)
              3'b000:data_x<=Data[31:28];
              3'b001:data_x<=Data[27:24];
              3'b010:data_x<=Data[23:20];
              3'b011:data_x<=Data[19:16];
              3'b100:data_x<=Data[15:12];
              3'b101:data_x<=Data[11:8];
              3'b110:data_x<=Data[7:4];
              3'b111:data_x<=Data[3:0];
              default:data_x[3:0]<=Data[3:0];
          endcase
       end
    SMG liu(data_x,BIT_SEL,AN,SEG);    
endmodule

module SMG(
      input [3:0] data,		      //要显示的数字
      input [2:0] bit_sel,       //数码管选择，000~111 最左到最右
      output reg [7:0] an,       //位选
      output reg [7:0] seg   	 //段选
);
    always@(*)
       begin
          case(bit_sel)
              3'b000:an=8'b01111111;
              3'b001:an=8'b10111111;
              3'b010:an=8'b11011111;
              3'b011:an=8'b11101111;
              3'b100:an=8'b11110111;
              3'b101:an=8'b11111011;
              3'b110:an=8'b11111101;
              3'b111:an=8'b11111110;
              default:an=8'b1111111;
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
				default:seg<=8'b11111111;
          endcase
       end
endmodule

/*module fpq(
  input reset,
  input clk_1M,
  output reg clk_1K
    );
    reg [8:0]counter;
    always@(negedge reset or posedge clk_1M)
    begin
      if(!reset)
        begin
           counter<=9'd0;
           clk_1K<=1'b0;
        end
      else if(counter==9'd500)
            begin
               clk_1K<=~clk_1K;
               counter<=9'd0;
            end
      else
           counter<=counter+1'b1; 
    end
endmodule*/
