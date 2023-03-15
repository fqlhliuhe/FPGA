`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 16:34:17
// Design Name: 
// Module Name: qwqw
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


module jcqdfz();
//INPUT
reg rst_n;
reg [4:0]R_Addr_A;
reg [4:0]R_Addr_B;
reg [4:0]W_Addr;
reg Reg_Write;
reg [31:0]W_Data;
reg clk_Regs;

//OUTPUT
wire [31:0]R_Data_A;
wire [31:0]R_Data_B;
initial
    begin   
            clk_Regs=0;rst_n=1;R_Addr_A=5'b00000;R_Addr_B=5'b00001;W_Data=32'h0000_0001;Reg_Write=0;W_Addr=5'b00111;#50;
            clk_Regs=1;rst_n=0;R_Addr_A=5'b00111;R_Addr_B=5'b00111;W_Data=32'hffff_ffff;Reg_Write=1;W_Addr=5'b00111;#50;
            clk_Regs=1;rst_n=0;R_Addr_A=5'b00111;R_Addr_B=5'b00111;W_Data=32'h1111_1111;Reg_Write=1;W_Addr=5'b00111;#50;
            clk_Regs=1;rst_n=0;R_Addr_A=5'b00111;R_Addr_B=5'b00111;W_Data=32'h0000_0001;Reg_Write=0;W_Addr=5'b00111;#50;
    end
Reg hh(rst_n,R_Addr_A,R_Addr_B,W_Addr,Reg_Write,W_Data,clk_Regs,R_Data_A,R_Data_B);
endmodule

