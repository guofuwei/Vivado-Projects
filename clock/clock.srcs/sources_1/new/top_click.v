module  top_clock(Hour,Minute,Second,CP,nCR,EN,Adj_Min,Adj_Hour,number,Light,clk,temp,change,AMTM,dingdong);
    output [7:0] Hour,Minute,Second;
	 output [3:0] Light,temp;
	 output [6:0] number;
    output clk,AMTM;//clkΪ��Ƶ֮���ʱ���źţ�Ƶ��Ϊ1Hz��AMTMΪ24����ת��12����ʱ����������ı���
	 output [5:0] dingdong; //dingdongΪ���㱨ʱʱ����˸�źš�	 
    input CP;//�����ʱ���źţ����Ƶ���������ʹ�á�
    input nCR;//����
    input EN,change;//ENΪʹ���źţ�changeΪ12/24����ת�����ء�
    input Adj_Min;//У�ֿ���
    input Adj_Hour; //Уʱ����
	 wire [7:0] Hour,Minute,Second;
	 reg clk;
	 reg [29:0] count,count1;//��Ƶ��Ҫ�ļ�����
	 reg [1:0] scan;//ɨ��ʱ��Ҫ�ļ�����
	 reg [3:0] Light,temp;//4Bit ����Light�����ĸ�����ܣ�temp��ʾ�������Ҫ��ʾ������
	 reg [6:0] number;//number����7�����������
	 reg clk1;//Ϊ��Ƶ���ɨ��Ƶ��
	 supply1 Vdd;
	 wire MinL_EN,MinH_EN,Hour_EN;//�м����
	// Hour,Minute,Second counter//
 //60�����������
	 counter10 U1(Second[3:0],nCR,EN,clk);//��λ
	 counter6 U2(Second[7:4],nCR,(Second[3:0]==4'h9),clk);//ʮλ
	//�������Ӽ�����ʹ���źš�Adj_Min=1��У�����ӣ�Adj_Min=0������������ʱ
	 assign MinL_EN=Adj_Min?Vdd:(Second==8'h59);
	 assign MinH_EN=(Adj_Min&&(Minute[3:0]==4'h9))||((Minute[3:0]==4'h9)&&(Second==8'h59));
	 //60���Ʒ��Ӽ�����
	 counter10 U3(Minute[3:0],nCR,MinL_EN,clk);
	 counter6 U4(Minute[7:4],nCR,MinH_EN,clk);
	//����Сʱ������ʹ���źš�Adj_Hour=1��У��Сʱ��Adj_Hour=0��Сʱ������ʱ 
	 assign Hour_EN=Adj_Hour?Vdd:((Minute==8'h59)&&(Second==8'h59));
//24���ƺ�12���ƿ��л���Сʱ������
    counter24 U5(Hour[7:4],Hour[3:0],nCR,Hour_EN,clk,change,AMTM);
//���㱨ʱģ��
	 dingdong U6(clk,nCR,Minute[7:4],Minute[3:0],Hour[7:4],Hour[3:0],dingdong[5:0]);
    
//��Ƶ
    always @(posedge CP)
     begin 
       if(~nCR)  count<=30'd00;  
       else if(count==30'd25000000) begin count<=30'd00; clk=~clk; end
       else count<=count+1'b1;
     end	//����1Hz��Ƶ��
	  always @(posedge CP)
     begin 
       if(~nCR)  count1<=30'd00;  
       else if(count1==30'd100000) begin count1<=30'd00; clk1=~clk1; end
       else count1<=count1+1'b1;
     end	//����ɨ���õ�Ƶ��
//ɨ�������	  
    always @(posedge clk1)
     begin 
       if(~nCR) scan<=2'b00;
       else if(scan==2'b11) scan<=2'b00;
       else scan<=scan+1'b1;	
     end	
//ɨ��
    always @ (scan[1:0])   
      begin
      case(scan[1:0])
      2'b00: Light<=4'b0111;  
      2'b01: Light<=4'b1011;
      2'b10: Light<=4'b1101;
      2'b11: Light<=4'b1110;
      endcase
      end
//��ʾ����
	 always @ (scan[1:0]) 
	   begin
      case(scan[1:0])
      2'b00: temp<=Hour[7:4];  
      2'b01: temp<=Hour[3:0];
      2'b10: temp<=Minute[7:4];
      2'b11: temp<=Minute[3:0];
      endcase
      end
	always @(temp)
    begin
     case(temp)
     4'd0:number<=7'b0000001;  //0
     4'd1:number<=7'b1001111;  //1
     4'd2:number<=7'b0010010;  //2
     4'd3:number<=7'b0000110;  //3
     4'd4:number<=7'b1001100;  //4
     4'd5:number<=7'b0100100;  //5
     4'd6:number<=7'b0100000;  //6
     4'd7:number<=7'b0001111;  //7
     4'd8:number<=7'b0000000;  //8
     4'd9:number<=7'b0000100;  //9
     default:number<=7'b0000001;
     endcase
    end
	 
  
endmodule
