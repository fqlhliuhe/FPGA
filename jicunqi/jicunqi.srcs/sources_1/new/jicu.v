`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/02 19:32:05
// Design Name: 
// Module Name: jicu
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


module jicu(
  input CLR,
  input CLK,
  input [3:0]D,
  input _OE,
  output  [3:0]Q
    );
   reg [3:0] TQ= 4'b0000;
   assign Q = _OE ? 4'bzzzz : TQ;
   always@(posedge CLK or posedge CLR)
   begin
        if(CLR) TQ<=4'B0000;
        else  TQ<=D;
   end
endmodule