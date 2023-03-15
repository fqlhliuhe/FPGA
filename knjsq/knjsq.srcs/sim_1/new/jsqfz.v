`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 18:40:14
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
reg CLR;
reg _LD;
reg CP;
reg P;
reg [3:0]D;
//OUTPUT
wire [3:0]Q;
initial
     begin
        CLR=0;_LD=0;CP=0;P=1;
		D=4'b0000;
		forever #60 D = D + 1'b1;
	  end
 always
     begin
         #100 _LD=~_LD;
     end
 always
     begin
         #300 CLR=~CLR;
     end
 always
     begin
         #15 CP=~CP;
     end
 always
     begin
        #50 P=~P;
     end
     knjsq he(CLR,CP,_LD,P,D,Q);
endmodule
