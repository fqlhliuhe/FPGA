`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/27 15:08:33
// Design Name: 
// Module Name: zdshj
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

module main(key, clk, rst, a_to_g, an, sel_goods, deal, goods_num_query, disp_dot, led);
//=========================输入和输出===========================================
input[1:0] key; //投币按钮
input clk; //计时器
input rst; //重置交易记录和数码管显示
input deal; //交易按钮
output [6:0] a_to_g; //数码管数字显示
output reg[3:0] an; //用来点亮数码管
output reg disp_dot; //小数点
input wire [2:0]sel_goods; // 用来选择商品 001代表可乐 011代表红茶 100代表乌龙茶
input goods_num_query; //库存查询
output reg [7:0] led;//灯光效果！
//=========================变量================================================
//把金额以角为单位
//num[15:12]表示商品价格的十位
//num[11:8]表示商品价格的个位
//num[7：4]表示输入金额的十位
//num[3:0]表示输入金额的个位
reg [15:0] num = 16'b0;
reg [3:0]disp_num; //数码管显示数字
reg [11:0]num_goods = 12'h555; //初始设置库存都为
reg [23:0]clk_cnt = 24'b0; //时钟计数
reg [26:0]blink_clk_cnt = 27'b0;//用于计数闪烁时间
reg [15:0] changes; //找零金额
reg ch_flag = 0; //找零标志位
reg goods_flag = 1; //库存标志位
reg deal_flag  = 0; //交易是否进行的标志位
wire deal_success_flag; //交易是否成功的标志
reg [3:0] num_goods_disp; //用于显示库存
reg [4:0] num_5_jiao = 4'b0; //投入的5角的数量
reg [4:0] num_1_yuan = 4'b0; //投入的1元的数量
reg blink_flag = 1; //闪烁标志
reg blink_rst;//闪烁重置

//=========================商品选择=============================================
//001代表可乐 对应的数字为20
//010代表红茶 对应的数字为35
//100代表乌龙茶 对应的数字为30
always @(posedge clk)
begin
case(sel_goods)
1:num[15:8] = 8'b00100000;
2:num[15:8] = 8'b00110101;
4:num[15:8] = 8'b00110000;
default:num[15:8] = 8'b00000000;
endcase
end


//=========================输入金额===========================================
//输入5角
always @(posedge key[0] or posedge rst)
begin
if (rst)
    num_5_jiao = 4'b0;
else
    begin
    if (key[0])
        num_5_jiao = num_5_jiao + 1;
    end
end
//输入1元
always @(posedge key[1] or posedge rst) 
begin
if (rst)
    num_1_yuan = 4'b0;
else
    begin
    if (key[1])
        num_1_yuan = num_1_yuan + 1;
    end
end

// 汇总金额
always @(posedge clk)
begin
    //个位数字（小数部分）只与5角的数量有关
    //5角的个数为奇数，则为5；个数为偶数，则为0
    if (num_5_jiao[0])
        num[3:0] = 4'b0101;
    else 
        num[3:0] = 4'b0;
    //十位数字则与1元和5角的数量有关
    //因为2个5角就是1元，所以只要取5角的个数的前三位
    num[7:4] = num_1_yuan + num_5_jiao[3:1];
end


//=========================交易===================================================
assign deal_success_flag = ch_flag & goods_flag;
always @(posedge deal or posedge rst)
begin
//按下rst按键，重置交易记录
if (rst)
    begin
    ch_flag <= 0;
    deal_flag <= 0;
    goods_flag <= 1;
    blink_rst <= 1;
    end
else
    begin
    blink_rst <= 0;
    deal_flag <= 1;
    //输入金额大于等于商品价格                                                    
    if (num[7:0] >= num[15:8])
        begin
        changes[15:8] <= 8'b0;
        //找零
        if (num[3:0] >= num[11:8])
            changes[7:0] <= num[7:0] - num[15:8];
        else 
            begin
            changes[3:0] <= 4'b0101;
            changes[7:4] <= num[7:4] - num[15:12] - 1;
            end
        
        //标志位
        ch_flag <= 1;
        //减去库存
        case(sel_goods)
            1:
            begin
            if (num_goods[3:0] >= 1)
                begin
                num_goods[3:0] <= num_goods[3:0] - 1;
                goods_flag <= 1;
                end
            else 
                goods_flag <= 0;
            end
            2:
            begin
            if (num_goods[7:4] >= 1)
                begin
                num_goods[7:4] <= num_goods[7:4] - 4'b1;
                goods_flag <= 1;
                end
            else 
                goods_flag <= 0;
            end
            4:
            begin
            if (num_goods[11:8] >= 1)
                begin
                num_goods[11:8] <= num_goods[11:8] - 1;
                goods_flag <= 1;
                end
            else 
                goods_flag <= 0;
            end
        
        default: num_goods <= num_goods;
        endcase
        end
    //输入金额小于商品价格
    else 
        ch_flag <= 0;
    end
end
//=========================库存查询以及库存改变=====================================
always @(posedge clk)
begin
if (goods_num_query)
    begin 
    case(sel_goods)
    1:num_goods_disp = num_goods[3:0];
    2:num_goods_disp = num_goods[7:4];
    4:num_goods_disp = num_goods[11:8];
    endcase
    end
end

//=========================数码管显示==============================================
always @(posedge clk)
begin
if (clk_cnt == 24'hFFFFFF)
    clk_cnt <= 24'b0;
else
    clk_cnt <= clk_cnt + 1;

//重置闪烁标志
if (blink_rst)
    blink_flag = 1;

//未进行交易时
if (!deal_flag)
    begin
    //查询库存
    if (goods_num_query)
        begin
        disp_num = disp_num_get(clk_cnt, num_goods_disp);
        an = an_get(clk_cnt);
        end
    else
        begin
        disp_dot = dot_get(clk_cnt, 4'b0101);
        disp_num = disp_num_get(clk_cnt, num);
        an = an_get(clk_cnt);
        end
    end
//交易后
else
    begin
    //交易成功，显示零钱
    if (deal_success_flag)
        begin
        //交易成功的灯光闪烁效果
        case (clk_cnt[23:21])
            0:led = 8'b00000001;
            1:led = 8'b00000010;
            2:led = 8'b00000100;
            3:led = 8'b00001000;
            4:led = 8'b00010000;
            5:led = 8'b00100000;
            6:led = 8'b01000000;
            7:led = 8'b10000000;
        endcase
        disp_dot = dot_get(clk_cnt, 4'b1101);
        disp_num = disp_num_get(clk_cnt, changes);
        an = an_get(clk_cnt);
        end
    //金额不足交易失败，闪烁数字6次，大约2秒
    else if (!ch_flag)
        begin
        if (blink_flag)
            begin
            blink_clk_cnt = blink_clk_cnt + 1;
            if (blink_clk_cnt[26] && blink_clk_cnt[25])
                begin
                blink_flag = 0;
                blink_clk_cnt = 0;
                end
            if (clk_cnt[23])
                begin
                disp_dot = dot_get(clk_cnt, 4'b0101);
                disp_num = disp_num_get(clk_cnt, num);
                an = an_get(clk_cnt);
                end         
            end
        else
            begin
            disp_dot = dot_get(clk_cnt, 4'b0101);
            disp_num = disp_num_get(clk_cnt, num);
            an = an_get(clk_cnt);
            end
        end
    //库存不足交易失败，显示库存，肯定是0啊
    else if(!goods_flag)
        begin
        disp_dot = dot_get(clk_cnt, 4'b1111);
        disp_num = disp_num_get(clk_cnt, 16'b0);
        an = an_get(clk_cnt);
        end
    end
end

//=========================得到显示数字函数=========================================
//根据计数器交替输出显示数字
function [3:0] disp_num_get;
    input [23:0] clk_cnt;
    input [16:0] num;
    begin
    case (clk_cnt[15:14])
        0:disp_num_get = num[3:0];
        1:disp_num_get = num[7:4];
        2:disp_num_get = num[11:8];
        3:disp_num_get = num[15:12];
    endcase
    end
endfunction

//=========================小数点显示函数==========================================
function dot_get;
    input [23:0] clk_cnt;
    input [3:0] dot;
    begin
    case (clk_cnt[15:14])
        0:dot_get = dot[0];
        1:dot_get = dot[1];
        2:dot_get = dot[2];
        3:dot_get = dot[3];
    endcase
    end
endfunction
//=========================数码管交替点亮函数=======================================
//根据计数器交替输出应该点亮的数码管
function [3:0] an_get;
    input [23:0] clk_cnt;
    begin
    case (clk_cnt[15:14])
        0:an_get = 4'b1110;
        1:an_get = 4'b1101;
        2:an_get = 4'b1011;
        3:an_get = 4'b0111;
    endcase
    end
endfunction

clk_sw_7seg_sub A1( .NUM(disp_num),
.a_to_g(a_to_g));
endmodule 

//=========================数码管显示模块===========================================
module clk_sw_7seg_sub(
input [3:0]NUM,
output reg[6:0]a_to_g
);

always @(*)
case(NUM)
0:a_to_g=7'b0000001;
1:a_to_g=7'b1001111;
2:a_to_g=7'b0010010;
3:a_to_g=7'b0000110;
4:a_to_g=7'b1001100;
5:a_to_g=7'b0100100;
6:a_to_g=7'b0100000;
7:a_to_g=7'b0001111;
8:a_to_g=7'b0000000;
9:a_to_g=7'b0000100;
'hA: a_to_g=7'b0001000;
'hB: a_to_g=7'b1100000;
'hC: a_to_g=7'b0110001;
'hD: a_to_g=7'b1000010;
'hE: a_to_g=7'b0110000;
'hF: a_to_g=7'b0111000;
default: a_to_g=7'b0000001;
endcase
endmodule