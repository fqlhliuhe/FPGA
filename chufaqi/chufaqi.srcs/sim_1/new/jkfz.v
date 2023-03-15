`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/23 10:16:41
// Design Name: 
// Module Name: jkfz
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


module jkfz;
   //INPUT
   reg J;
   reg K;
   reg CLK;
   //OUTPUT
   wire Q;
   wire _Q_;
   reg [3:0]T;
   zcjk wo(CLK,J,K,Q,_Q_);
   always
     begin
        #10 CLK=~CLK;
     end
   initial
     begin
        CLK=0;
        T=2'b00;
        forever #20 T = T + 1'b1;
     end
     always @(*)
		{J,K}=T;
endmodule
