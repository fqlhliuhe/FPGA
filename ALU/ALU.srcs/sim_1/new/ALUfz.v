`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/24 20:36:52
// Design Name: 
// Module Name: ALUfz
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


module ALUfz();
//INPUT
reg [3:0]ALU_OP;
reg [31:0]ALU_A;
reg [31:0]ALU_B;
//OUTPUT
wire [31:0]ALU_F;
wire ZF,SF,CF,OF;
initial
    begin
         //思考题3
            ALU_OP=4'b0000;ALU_A=32'h7FFF_FFF0; ALU_B=32'h7FFF_FFFF;#50;//加
            ALU_OP=4'b1000;ALU_A=32'h7FFF_FFF0; ALU_B=32'h7FFF_FFFF;#50;//减
        //加法
            ALU_OP=4'b0000;ALU_A=32'h0000_0000; ALU_B=32'h0000_0000;#50;
            ALU_OP=4'b0000;ALU_A=32'h0000_0001; ALU_B=32'h0000_0001;#50;
            ALU_OP=4'b0000;ALU_A=32'h5555_5555; ALU_B=32'h9999_9999;#50;
            ALU_OP=4'b0000;ALU_A=32'h00FF_00FF; ALU_B=32'h5F5F_5F5F;#50;
            ALU_OP=4'b0000;ALU_A=32'hF0F0_F0F0; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b0000;ALU_A=32'hF000_0004; ALU_B=32'h1000_000F;#50;
        //左移
            ALU_OP=4'b0001;ALU_A=32'h0000_0000; ALU_B=32'h0000_0001;#50;
            ALU_OP=4'b0001;ALU_A=32'h0000_0000; ALU_B=32'h0000_0000;#50;
            ALU_OP=4'b0001;ALU_A=32'h5555_5555; ALU_B=32'h9999_9999;#50;
            ALU_OP=4'b0001;ALU_A=32'h00FF_00FF; ALU_B=32'h5F5F_5F5F;#50;
            ALU_OP=4'b0001;ALU_A=32'hF0F0_F0F0; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b0001;ALU_A=32'h0000_0004; ALU_B=32'hEFEF_EFEF;#50;
        //有符号比较
            ALU_OP=4'b0010;ALU_A=32'hFFF8_0001; ALU_B=32'hFFF8_0002;#50;
            ALU_OP=4'b0010;ALU_A=32'h0000_0000; ALU_B=32'h0000_0001;#50;
            ALU_OP=4'b0010;ALU_A=32'h0000_0000; ALU_B=32'h0000_0000;#50;
            ALU_OP=4'b0010;ALU_A=32'h5555_5555; ALU_B=32'h9999_9999;#50;
            ALU_OP=4'b0010;ALU_A=32'h00FF_00FF; ALU_B=32'h5F5F_5F5F;#50;
            ALU_OP=4'b0010;ALU_A=32'hF0F0_F0F0; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b0010;ALU_A=32'h0000_0004; ALU_B=32'hEFEF_EFEF;#50;
        //无符号比较
            ALU_OP=4'b0011;ALU_A=32'hFFF8_0001; ALU_B=32'hFFF8_0002;#50;
            ALU_OP=4'b0011;ALU_A=32'h0000_0000; ALU_B=32'h0000_0001;#50;
            ALU_OP=4'b0011;ALU_A=32'h0000_0000; ALU_B=32'h0000_0000;#50;
            ALU_OP=4'b0011;ALU_A=32'h5555_5555; ALU_B=32'h9999_9999;#50;
            ALU_OP=4'b0011;ALU_A=32'h00FF_00FF; ALU_B=32'h5F5F_5F5F;#50;
            ALU_OP=4'b0011;ALU_A=32'hF0F0_F0F0; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b0011;ALU_A=32'h0000_0004; ALU_B=32'hEFEF_EFEF;#50;
        //异或
            ALU_OP=4'b0100;ALU_A=32'h7FFF_FFFF; ALU_B=32'h7FFF_FFFF;#50;
            ALU_OP=4'b0100;ALU_A=32'hFFFF_FFFF; ALU_B=32'hFFFF_FFFF;#50;
            ALU_OP=4'b0100;ALU_A=32'h5555_5555; ALU_B=32'h9999_9999;#50;
            ALU_OP=4'b0100;ALU_A=32'h00FF_00FF; ALU_B=32'h5F5F_5F5F;#50;
            ALU_OP=4'b0100;ALU_A=32'hF0F0_F0F0; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b0100;ALU_A=32'h0000_0004; ALU_B=32'hEFEF_EFEF;#50;
        //逻辑右移，高位补零
            ALU_OP=4'b0101;ALU_A=32'h7FFF_FFFF; ALU_B=32'h7FFF_FFFD;#50;
            ALU_OP=4'b0101;ALU_A=32'h7FFF_FFFF; ALU_B=32'hFFFF_FFFF;#50;
            ALU_OP=4'b0101;ALU_A=32'h5555_5555; ALU_B=32'h9999_9999;#50;
            ALU_OP=4'b0101;ALU_A=32'h00FF_00FF; ALU_B=32'h5F5F_5F5F;#50;
            ALU_OP=4'b0101;ALU_A=32'hF0F0_F0F0; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b0101;ALU_A=32'h0000_0004; ALU_B=32'hEFEF_EFEF;#50;
        //按位或
            ALU_OP=4'b0110;ALU_A=32'h7FFF_FFFF; ALU_B=32'h8FFF_FFFF;#50;
            ALU_OP=4'b0110;ALU_A=32'hFFFF_FFFF; ALU_B=32'h7FFF_FFFF;#50;
            ALU_OP=4'b0110;ALU_A=32'h5555_5555; ALU_B=32'h9999_9999;#50;
            ALU_OP=4'b0110;ALU_A=32'h00FF_00FF; ALU_B=32'h5F5F_5F5F;#50;
            ALU_OP=4'b0110;ALU_A=32'hF0F0_F0F0; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b0110;ALU_A=32'h0000_0004; ALU_B=32'hEFEF_EFEF;#50;
        //按位与
            ALU_OP=4'b0111;ALU_A=32'h0000_0001; ALU_B=32'h0000_0001;#50;
            ALU_OP=4'b0111;ALU_A=32'h0000_0001; ALU_B=32'h0000_0008;#50;
            ALU_OP=4'b0111;ALU_A=32'h5555_5555; ALU_B=32'h9999_9999;#50;
            ALU_OP=4'b0111;ALU_A=32'h00FF_00FF; ALU_B=32'h5F5F_5F5F;#50;
            ALU_OP=4'b0111;ALU_A=32'hF0F0_F0F0; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b0111;ALU_A=32'h0000_0004; ALU_B=32'hEFEF_EFEF;#50;
        //减法
            ALU_OP=4'b1000;ALU_A=32'h0000_0001; ALU_B=32'h0000_0001;#50;
            ALU_OP=4'b1000;ALU_A=32'h0000_0001; ALU_B=32'h0000_0008;#50;
            ALU_OP=4'b1000;ALU_A=32'h5555_5555; ALU_B=32'h9999_9999;#50;
            ALU_OP=4'b1000;ALU_A=32'h00FF_00FF; ALU_B=32'h5F5F_5F5F;#50;
            ALU_OP=4'b1000;ALU_A=32'hF0F0_F0F0; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b1000;ALU_A=32'h0000_0004; ALU_B=32'hEFEF_EFEF;#50;
        //算术右移，高位补ALU_A[31]
            ALU_OP=4'b1101;ALU_A=32'h0000_0001; ALU_B=32'h0000_0001;#50;
            ALU_OP=4'b1101;ALU_A=32'h0000_0001; ALU_B=32'h0000_0008;#50;
            ALU_OP=4'b1101;ALU_A=32'h5555_5555; ALU_B=32'h9999_9999;#50;
            ALU_OP=4'b1101;ALU_A=32'h00FF_00FF; ALU_B=32'h5F5F_5F5F;#50;
            ALU_OP=4'b1101;ALU_A=32'hF0F0_F0F0; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b1101;ALU_A=32'h0000_0004; ALU_B=32'hEFEF_EFEF;#50;
            ALU_OP=4'b1101;ALU_A=32'hFFF8_0F0F; ALU_B=32'h0000_0004;#50;
            ALU_OP=4'b1101;ALU_A=32'h0FF8_0F0F; ALU_B=32'h0000_0004;#50;
    end
ALU fz(ALU_OP,ALU_A,ALU_B,ALU_F,ZF,SF,CF,OF);
endmodule