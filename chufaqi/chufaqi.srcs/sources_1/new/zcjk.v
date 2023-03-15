`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/23 09:53:10
// Design Name: 
// Module Name: zcjk
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


module zcjk(CLK,J,K,Q,_Q_);
   input CLK;
   input J;
   input K;
   output reg Q;
   output _Q_;
   always@(posedge CLK)
         begin
              case({J,K})
              2'b00: Q<=Q;
              2'b01: Q<=0;
              2'b10: Q<=1;
              2'b11: Q<=~Q;
              default: Q<=Q;
              endcase
          end
     assign _Q_=~Q;
endmodule
