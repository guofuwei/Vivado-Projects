`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module counter10(Q,nCR,EN,CP);
    output [3:0] Q;
    input CP;
    input nCR;
    input EN;
	 reg [3:0] Q;
	 always @(posedge CP or negedge nCR)
	 begin
	 if(~nCR) Q<=4'b0000;//nCR=0，计数器被异步清零
	 else if(~EN) Q<=Q;//EN=0，暂停计数
	 else if(Q==4'b1001) Q<=4'b0000;
	 else Q<=Q+1'b1;//计数器增加1
	 end

endmodule

