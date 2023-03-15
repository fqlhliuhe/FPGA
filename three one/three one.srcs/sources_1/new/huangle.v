`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/11 19:11:59
// Design Name: 
// Module Name: huangle
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


module huangle(
    input [1:0] A,
    input [1:0] B,
    input [1:0] C,
    input [1:0] D,
    input [1:0] S,
    input _EN_,
    output reg [1:0]Y
);
always @(*)
   begin
      if(_EN_==0)
               begin
                if(S==2'b00) Y=A;
                else if(S==2'b01) Y=B;
                else if(S==2'b10) Y=C;
                else if(S==2'b11) Y=D;
               end
      else Y=2'b00;
  end     
endmodule
