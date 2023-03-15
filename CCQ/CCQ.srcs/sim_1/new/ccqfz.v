`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 14:42:21
// Design Name: 
// Module Name: ccqfz
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
module ccqfz();
//INPUT
reg clka;
reg wea;
reg [5:0]addra;
reg [31:0]dina;
//OUTPUT
wire [31:0]douta;
initial
     begin
        clka=0;
		addra=6'b000000;
		forever #50 addra = addra + 1'b1;
	  end

 always
     begin
        #25 clka=~clka;
     end
/*initial
    begin
        #50 addra=5'b000000;wea=0;dina=32'hFFFF_0F0F;
        #50 addra=5'b000001;wea=0;dina=32'hFFFF_0F0F;
        #50 addra=5'b000010;wea=0;dina=32'hFFFF_0F0F;
        #50 addra=5'b000011;wea=0;dina=32'hFFFF_0F0F;
        #50 addra=5'b000100;wea=0;dina=32'hFFFF_0F0F;
        #50 addra=5'b000101;wea=0;dina=32'hFFFF_0F0F;
        #50 addra=5'b000111;wea=0;dina=32'hFFFF_0F0F;
        #50 addra=5'b000111;wea=1;dina=32'hFFFF_0F0F;
        #50 addra=5'b000111;wea=0;dina=32'hFFFF_0F0F;
    end*/

RAM_B vv(
  .clka(clka),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [5 : 0] addra
  .dina(dina),    // input wire [31 : 0] dina
  .douta(douta)  // output wire [31 : 0] douta
);
endmodule
