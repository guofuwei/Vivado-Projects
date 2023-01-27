module  top_clock(Hour,Minute,Second,CP,nCR,EN,Adj_Min,Adj_Hour,number,Light,clk,temp,change,AMTM,dingdong);
    output [7:0] Hour,Minute,Second;
	 output [3:0] Light,temp;
	 output [6:0] number;
    output clk,AMTM;//clk为分频之后的时钟信号，频率为1Hz，AMTM为24进制转换12进制时表明上下午的变量
	 output [5:0] dingdong; //dingdong为整点报时时的闪烁信号。	 
    input CP;//输入的时钟信号，需分频后才能正常使用。
    input nCR;//清零
    input EN,change;//EN为使能信号，change为12/24进制转换开关。
    input Adj_Min;//校分控制
    input Adj_Hour; //校时控制
	 wire [7:0] Hour,Minute,Second;
	 reg clk;
	 reg [29:0] count,count1;//分频需要的计数器
	 reg [1:0] scan;//扫描时需要的计数器
	 reg [3:0] Light,temp;//4Bit 变量Light代表四个数码管，temp表示数码管需要显示的数字
	 reg [6:0] number;//number代表7个发光二极管
	 reg clk1;//为分频后的扫描频率
	 supply1 Vdd;
	 wire MinL_EN,MinH_EN,Hour_EN;//中间变量
	// Hour,Minute,Second counter//
 //60进制秒计数器
	 counter10 U1(Second[3:0],nCR,EN,clk);//个位
	 counter6 U2(Second[7:4],nCR,(Second[3:0]==4'h9),clk);//十位
	//产生分钟计数器使能信号。Adj_Min=1，校正分钟；Adj_Min=0，分钟正常计时
	 assign MinL_EN=Adj_Min?Vdd:(Second==8'h59);
	 assign MinH_EN=(Adj_Min&&(Minute[3:0]==4'h9))||((Minute[3:0]==4'h9)&&(Second==8'h59));
	 //60进制分钟计数器
	 counter10 U3(Minute[3:0],nCR,MinL_EN,clk);
	 counter6 U4(Minute[7:4],nCR,MinH_EN,clk);
	//产生小时计数器使能信号。Adj_Hour=1，校正小时；Adj_Hour=0，小时正常计时 
	 assign Hour_EN=Adj_Hour?Vdd:((Minute==8'h59)&&(Second==8'h59));
//24进制和12进制可切换的小时计数器
    counter24 U5(Hour[7:4],Hour[3:0],nCR,Hour_EN,clk,change,AMTM);
//整点报时模块
	 dingdong U6(clk,nCR,Minute[7:4],Minute[3:0],Hour[7:4],Hour[3:0],dingdong[5:0]);
    
//分频
    always @(posedge CP)
     begin 
       if(~nCR)  count<=30'd00;  
       else if(count==30'd25000000) begin count<=30'd00; clk=~clk; end
       else count<=count+1'b1;
     end	//产生1Hz的频率
	  always @(posedge CP)
     begin 
       if(~nCR)  count1<=30'd00;  
       else if(count1==30'd100000) begin count1<=30'd00; clk1=~clk1; end
       else count1<=count1+1'b1;
     end	//产生扫描用的频率
//扫描计数器	  
    always @(posedge clk1)
     begin 
       if(~nCR) scan<=2'b00;
       else if(scan==2'b11) scan<=2'b00;
       else scan<=scan+1'b1;	
     end	
//扫描
    always @ (scan[1:0])   
      begin
      case(scan[1:0])
      2'b00: Light<=4'b0111;  
      2'b01: Light<=4'b1011;
      2'b10: Light<=4'b1101;
      2'b11: Light<=4'b1110;
      endcase
      end
//显示数字
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
