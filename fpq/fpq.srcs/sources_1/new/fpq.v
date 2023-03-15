`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 17:05:03
// Design Name: 
// Module Name: fpq
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


module fpq(
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
endmodule

module dtime(
   input rst,
   input clk_16M,
   output clk_2M
);
 reg[2:0]cnt;
 always@(posedge clk_16M or posedge rst)
        begin
           if(rst)
               cnt<=3'd0;
           else
              cnt<=cnt+1'b1;    
        end
 assign clk_2M=cnt[2];
 endmodule
