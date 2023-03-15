`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/02 19:32:31
// Design Name: 
// Module Name: jicunfz
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


module jicunfz;
//INPUT
reg _OE;
reg CLR;
reg CLK;
reg [3:0]D;
//OUTPUT
wire [3:0]Q;
jicu ke(CLR,CLK,D,_OE,Q);
  always
     begin
        #10 CLK=~CLK;
        #15 CLR=~CLR;
        #20 _OE=~_OE;
     end
   initial
     begin
        CLK=0;_OE=0;CLR=0;
        D=4'b0000;
        forever #25 D = D + 1'b1;       
	  end
endmodule
