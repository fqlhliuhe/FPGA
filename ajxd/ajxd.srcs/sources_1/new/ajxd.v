`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 08:09:49
// Design Name: 
// Module Name: ajxd
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


module ajxd(
   input rst,
   input clk,
   input key,  
   output reg key_pulse
    );
    parameter S0=3'd0,S1=3'd1,S2=3'd2,S3=3'd3,S4=3'd4,S5=3'd5;
    reg [2:0]ST;
    always @(posedge rst or posedge clk)
    begin
       if(rst)
           begin
              ST<=key ? S3 : S0;
              key_pulse <= key;
           end
       else
           case(ST)
                S0:begin ST<=key ? S1 : S0; key_pulse <= 1'b0; end
                S1:begin ST<=key ? S3 : S2; key_pulse <= key; end
                S2:begin ST<=key ? S1 : S0; key_pulse <= 1'b0; end
                S3:begin ST<=key ? S3 : S4; key_pulse <= 1'b1; end
                S4:begin ST<=key ? S5 : S0; key_pulse <= key; end
                S5:begin ST<=key ? S3 : S4; key_pulse <= 1'b1; end
                default:begin ST<=key ? S3 : S0; key_pulse <= 1'b0; end
           endcase
    end
endmodule
