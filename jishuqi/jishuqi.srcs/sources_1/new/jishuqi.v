`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/07 09:58:48
// Design Name: 
// Module Name: jishuqi
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



module jishuqi(
  input EN,
  input CLK,
  input [3:0]D,
  input _MR,
  input _Load,
  output reg [3:0]Q,
  output reg CO
    );
   always@(posedge CLK or negedge _MR)
   begin
        if(!_MR)
          begin
            Q<=4'b0000;
            CO<=0;
          end
        else
          begin//_MR=1
            if(_Load==1)
              begin 
               if(EN==1) 
                  begin
                     Q=Q+4'b1;
                     if(Q==4'b1111) CO=1; 
                     else CO<=0;
                  end//EN=1
               else begin Q<=Q;CO<=CO;end//EN=0
              end//_Load=1
            else begin Q<=D;CO<=CO;end//_Load=0
          end//_MR=1    
   end//always
endmodule
