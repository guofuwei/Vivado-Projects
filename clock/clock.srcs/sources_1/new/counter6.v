`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module counter6(Q,nCR,EN,CP);
    output [3:0] Q;
    input CP;
    input nCR;
    input EN;
	 reg [3:0] Q;
	 always @(posedge CP or negedge nCR)
	 begin
	 if(~nCR) Q<=4'b0000;
	 else if(~EN) Q<=Q;
	 else if(Q==4'b0101) Q<=4'b0000;
	 else Q<=Q+1'b1;
	 end

endmodule

