`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/13 21:56:15
// Design Name: 
// Module Name: sixone
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


module sevenone(SW,PC_Out,inst,W_Data,ALU_A,ALU_B,F,MDR_data,Choice);
    input [2:0]SW;
    input [31:0]PC_Out;
    input [31:0]inst;
    input [31:0]W_Data;
    input [31:0]ALU_A;
    input [31:0]ALU_B;
    input [31:0]F;
    input [31:0]MDR_data;
    output reg [31:0]Choice;
    always@(*)
    begin
       case(SW)
              3'b000:begin Choice=PC_Out; end
              3'b001:begin Choice=inst; end
              3'b010:begin Choice=W_Data; end
              3'b011:begin Choice=ALU_A; end
              3'b100:begin Choice=ALU_B; end
              3'b101:begin Choice=F; end
              3'b110:begin Choice=MDR_data; end
              default:begin Choice=PC_Out;end
       endcase
    end
endmodule
