`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 18:38:26
// Design Name: 
// Module Name: knjsq
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


module knjsq(
  input CLR,
  input CP,
  input _LD,
  input P,//еп╤опе╨е
  input [3:0]D,
  output [3:0]Q
    );
  reg [3:0]TQ=4'b0000;
  assign Q=TQ;
  always@(posedge CLR or negedge _LD or posedge CP)
          begin
               if(CLR) TQ=4'b0000;
               else if(!_LD) TQ<=D;
               else if(P) TQ<=TQ+4'b1;
               else TQ<=TQ-4'b1;
          end
  endmodule
   /*wire [3:0]TQ=4'b0000; 
   assign TQ = CLR ? 4'b0000 : TQ;
   assign TQ = (!CLR&&!_LD) ? D : TQ;
   always@(posedge CP_up or posedge CP_down)
          begin
             if(!CLR&&_LD)
               begin
                  if(CP_down)
                         begin
                             Q=Q+4'b1;
                         end
                  if(CP_up)
                        begin
                           Q=Q-4'b1;
                        end 
               end
          end  
    always(*)
       begin
          Q<=TQ; 
       end
  endmodule*/
  /*always@(posedge CLR or negedge _LD or posedge CP_up or posedge CP_down)
    begin
        if(CLR) Q<=4'b0000;
        else if(!_LD) Q<=D;
        else if(CP_down) Q<=Q+4'b1;
        else if(CP_up) Q<=Q-4'b1;
        else Q<=Q;
    end
 endmodule*/
 /*always@(posedge CLR or negedge _LD or posedge CP_up)
    begin
        if(CLR) Q<=4'b0000;
        else if(!_LD) Q<=D;
        else if(CP_up) Q<=Q-4'b1;
        else Q<=Q;
    end
  always@(posedge CLR or negedge _LD or posedge CP_down)
    begin
        if(CLR) Q<=4'b0000;
        else if(!_LD) Q<=D;
        else if(CP_up) Q<=Q-4'b1;
        else Q<=Q;
    end
 endmodule*/
 
/*module jiafa(
     input [3:0]TQ,
     input CP_up,
     output reg [3:0]Q
 );
  always@(posedge CP_up)
    begin
        Q<=Q+4'b1;
    end
 endmodule
 
module jianfa(
     input [3:0]D,
     input CP_down,
     output reg [3:0]Q
 );
  always@(posedge CP_down)
    begin
      Q<=Q-4'b1;
    end
 endmodule*/