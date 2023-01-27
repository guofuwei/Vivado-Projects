`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module counter24(CntH,CntL,nCR,EN,CP,change,AMTM);
    output [3:0] CntH;
    output [3:0] CntL;
	 output AMTM;
    input nCR;
    input EN;
    input CP,change;
	 reg [3:0] CntH,CntL;
	 reg AMTM; 
	 	
	 
	 always @(posedge CP or negedge nCR)
	 begin
	
	  if(~nCR) {CntH,CntL}<=8'h00;//清零
	  else if(change==0)//判断12或者24小时进制。change=0时为24进制，change=1时为12进制
	  begin AMTM<=0;//上下午显示关闭
if(~EN) {CntH,CntL}<={CntH,CntL};//暂停计数
	  else
	  begin
	 
	if((CntH>4'b0010)||(CntL>4'b1001)||((CntH==4'b0010)&&(CntL>=4'b0011)))
	   {CntH,CntL}<=8'h00;
	  else if((CntH==4'b0010)&&(CntL<4'b0011))
	   begin CntH<=CntH; CntL<=CntL+1'b1; end
	  else if(CntL==4'b1001)
	   begin CntH<=CntH+1'b1; CntL<=4'b0000; end
	  else
	   begin CntH<=CntH; CntL<=CntL+1'b1; end
	   end
	   end//24进制小时计数模块完成
	 else if(change==1)//进入12小时计数模块
	 begin
	  if(CntH>=4'b0001&&CntL>4'b0010) begin CntH<=CntH-1'b1; CntL<=CntL-2'b10; AMTM<=1; end//AMTM=1.，表示为下午
	  else if(~EN) {CntH,CntL}<={CntH,CntL};
	  else
	  begin
	  if((CntH>4'b0001)||(CntL>4'b1001)||((CntH==4'b0001)&&(CntL>=4'b0010)))
	   begin {CntH,CntL}<=8'h01; AMTM<=~AMTM; end//完成一次12小时计数，AMTM翻转一次，表示上下午的转换
	  else if((CntH==4'b0001)&&(CntL<4'b0001))
	   begin CntH<=CntH; CntL<=CntL+1'b1; end
	  else if(CntL==4'b1001)
	   begin CntH<=CntH+1'b1; CntL<=4'b0000; end
	  else
	   begin CntH<=CntH; CntL<=CntL+1'b1; end
	 end
	 end//12进制小时计数完成
	 end
	endmodule
