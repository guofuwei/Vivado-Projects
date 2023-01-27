`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module dingdong(clk,ncr,minuteh,minutel,hourh,hourl,dingdong);
    input ncr;
    input clk;
    input [3:0] minuteh,minutel;
    input [3:0] hourh,hourl;
    output reg [5:0] dingdong;
    integer i=0;
    reg en;
    always@(posedge clk or negedge ncr)
    begin
    if(~ncr)
    begin
		dingdong<= 6'b000000;
    end
    else if((minuteh==4'd5)&&(minutel==4'd9))
    begin
    i=0;
    en<=1;
    end
    else if((i<(hourh*20+hourl*2))&&(en))
    begin
		dingdong<=~dingdong;
    i=i+1;
    end
    else if(i==(hourh*20+hourl*2))
    en<=0;
    else
    dingdong<=0;
    end
    endmodule
