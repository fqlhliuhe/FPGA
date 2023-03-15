`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/31 22:20:56
// Design Name: 
// Module Name: zhilin
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


module zhilin(rst_n,IR_Write,PC_Write,clk_im,inst,PC);
   input rst_n;
   input IR_Write;
   input PC_Write;
   input clk_im;
   output [31:0]inst;
   output [31:0]PC;
   wire clk_fim;
   wire [31:0]PC_Out;
   wire [31:0]Inst_Code;
   assign clk_fim=~clk_im;
   PC aa(rst_n,PC_Write,clk_fim,PC_Out);
   assign PC=PC_Out;
   RAM_B IM(     //´æ´¢Æ÷
  .clka(clk_im),    // input wire clka
  .addra(PC_Out[7:2]),  // input wire [5 : 0] addra
  .douta(Inst_Code)  // output wire [31 : 0] douta
  );
   IR cc(Inst_Code,clk_fim,IR_Write,inst);
endmodule
