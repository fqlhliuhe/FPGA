`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 12:10:14
// Design Name: 
// Module Name: chucun
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


/*module chucun(CLR,clk_1M,clka,wea,addra,choice,AN,seg);
 input CLR;
 input clk_1M;
 input wire clka;
 input wire [0 : 0] wea;
 input wire [5 : 0] addra;
 input [2:0]choice;
 wire [31 : 0] dina;
 output [7:0]AN;
 output [7:0]seg;
 wire CLK;
 wire [31:0]douta;
 xuanze ss(choice,dina);
  RAM_B aa(
  .clka(clka),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [5 : 0] addra
  .dina(dina),    // input wire [31 : 0] dina
  .douta(douta)  // output wire [31 : 0] douta
);
fpq gg(CLR,clk_1M,CLK);
smgsm ff(CLK,CLR,douta,AN,seg);
endmodule

module xuanze(choice,dina);
   input [2:0]choice;
   output  reg [31:0]dina;
   always@(*)
       begin
          case(choice)
              3'b000:dina=32'hffff_0f0f;
              3'b001:dina=32'h1111_1111;
              3'b010:dina=32'h2222_3333;
              3'b011:dina=32'habcd_3456;
              3'b100:dina=32'h2173_9803;
              3'b101:dina=32'hdadb_caca;
              3'b110:dina=32'h0000_0000;
              3'b111:dina=32'haaaa_bbbb;
          endcase
       end
endmodule*/