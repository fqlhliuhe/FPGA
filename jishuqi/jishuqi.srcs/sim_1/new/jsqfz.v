`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/07 09:59:13
// Design Name: 
// Module Name: jsqfz
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


module jsqfz;
//INPUT
reg EN;
reg _MR;
reg _Load;
reg CLK;
reg [3:0]D;
//OUTPUT
wire [3:0]Q;
wire CO;
initial
     begin
        CLK=0;_MR=0;_Load=0;EN=0;
		D=4'b0000;
		forever #60 D = D + 1'b1;
	  end
 always
     begin
         #10 CLK=~CLK;
     end
 always
     begin
         #300 _MR=~_MR;
     end
 always
     begin
         #15 EN=~EN;
     end
 always
     begin
        #25 _Load=~_Load;
     end
     jishuqi he(EN,CLK,D,_MR,_Load,Q,CO);

endmodule

