`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/19 18:27:43
// Design Name: 
// Module Name: zy1si
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

//数据流描述方式
module zy1si;
    reg A1,A0,B1,B0;
    wire F;
    zy1 na(A1,A0,B1,B0,F);
    initial
       begin
            A1=0;A0=0;B1=0;B0=0;
         #5 A1=0;A0=0;B1=0;B0=1;
         #5 A1=0;A0=0;B1=1;B0=0;
         #5 A1=0;A0=0;B1=1;B0=1;
         #5 A1=0;A0=1;B1=0;B0=0;
         #5 A1=0;A0=1;B1=0;B0=1;
         #5 A1=0;A0=1;B1=1;B0=0;
         #5 A1=0;A0=1;B1=1;B0=1;
         #5 A1=1;A0=0;B1=0;B0=0;
         #5 A1=1;A0=0;B1=0;B0=1;
         #5 A1=1;A0=0;B1=1;B0=0;
         #5 A1=1;A0=0;B1=1;B0=1;
         #5 A1=1;A0=1;B1=0;B0=0;
         #5 A1=1;A0=1;B1=0;B0=1;
         #5 A1=1;A0=1;B1=1;B0=0;
         #5 A1=1;A0=1;B1=1;B0=1;
      
       end
endmodule
/*
module zy1si;

	reg A0;
	reg A1;
	reg B0;
	reg B1;

	wire F;

	zy1 na (
		.A0(A0), 
		.A1(A1), 
		.B0(B0), 
		.B1(B1)
	);
	initial begin
		A0 = 0;A1 = 0;B0 = 0;B1 = 0;
		#100;
      {A0,A1,B0,B1}=5'd1;  
		#100;
      {A0,A1,B0,B1}=5'd2;  
		#100;
      {A0,A1,B0,B1}=5'd3;  
		#100;
      {A0,A1,B0,B1}=5'd4;  
		#100;
      {A0,A1,B0,B1}=5'd5;  
		#100;
      {A0,A1,B0,B1}=5'd6;  
		#100;
      {A0,A1,B0,B1}=5'd7;  
		#100;
      {A0,A1,B0,B1}=5'd8;  
		#100;
      {A0,A1,B0,B1}=5'd9;  
		#100;
      {A0,A1,B0,B1}=5'd10;  
		#100;
      {A0,A1,B0,B1}=5'd11;  
		#100;
      {A0,A1,B0,B1}=5'd12;  
		#100;
      {A0,A1,B0,B1}=5'd13;  
		#100;
      {A0,A1,B0,B1}=5'd14;  
		#100;
      {A0,A1,B0,B1}=5'd15;  
	end
 endmodule
*/
/*
module zy1si;

	reg A0;
	reg A1;
	reg B0;
	reg B1;

	wire F;

	zy1 na (
		.A0(A0), 
		.A1(A1), 
		.B0(B0), 
		.B1(B1)
	);

	reg [1:4] T;
	initial
	begin
		T = 5'b0;
		forever #50 T = T + 1'b1;
	end

	always @(*)
		{A0,A1,B0,B1}=T;

endmodule
*/