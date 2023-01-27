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
	
	  if(~nCR) {CntH,CntL}<=8'h00;//����
	  else if(change==0)//�ж�12����24Сʱ���ơ�change=0ʱΪ24���ƣ�change=1ʱΪ12����
	  begin AMTM<=0;//��������ʾ�ر�
if(~EN) {CntH,CntL}<={CntH,CntL};//��ͣ����
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
	   end//24����Сʱ����ģ�����
	 else if(change==1)//����12Сʱ����ģ��
	 begin
	  if(CntH>=4'b0001&&CntL>4'b0010) begin CntH<=CntH-1'b1; CntL<=CntL-2'b10; AMTM<=1; end//AMTM=1.����ʾΪ����
	  else if(~EN) {CntH,CntL}<={CntH,CntL};
	  else
	  begin
	  if((CntH>4'b0001)||(CntL>4'b1001)||((CntH==4'b0001)&&(CntL>=4'b0010)))
	   begin {CntH,CntL}<=8'h01; AMTM<=~AMTM; end//���һ��12Сʱ������AMTM��תһ�Σ���ʾ�������ת��
	  else if((CntH==4'b0001)&&(CntL<4'b0001))
	   begin CntH<=CntH; CntL<=CntL+1'b1; end
	  else if(CntL==4'b1001)
	   begin CntH<=CntH+1'b1; CntL<=4'b0000; end
	  else
	   begin CntH<=CntH; CntL<=CntL+1'b1; end
	 end
	 end//12����Сʱ�������
	 end
	endmodule
