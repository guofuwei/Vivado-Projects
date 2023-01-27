#include <xil_io.h>
#include<stdio.h>
#include <xgpio_l.h>
int main()
{
	unsigned short last_sw,current_sw,button;
	Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_TRI_OFFSET,0xffff);
	Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_TRI2_OFFSET,0x0);
	Xil_Out8(XPAR_AXI_GPIO_1_BASEADDR+XGPIO_TRI_OFFSET,0x0);
	Xil_Out8(XPAR_AXI_GPIO_1_BASEADDR+XGPIO_TRI2_OFFSET,0x0);
	Xil_Out8(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_TRI_OFFSET,0x1f);
	while(1)
	{
		last_sw=current_sw;
		current_sw=Xil_In16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_DATA_OFFSET)&0xffff;
		button=Xil_In8(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_DATA_OFFSET)&0x1f;
		if((last_sw!=current_sw)||(button!=0))
		{
			if(last_sw!=current_sw)
			{
				Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_DATA2_OFFSET, current_sw);
//				xil_printf("%x\n",current_sw);
			}
			else
			{
//				button=Xil_In8(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_DATA_OFFSET)&0x1f;
				while((Xil_In8(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_DATA_OFFSET)&0x1f)!=0);
				switch(button)
				   {
					 case(0x1): //C  1000110
					   Xil_Out8(XPAR_AXI_GPIO_1_BASEADDR+XGPIO_DATA2_OFFSET,0x46);//输出对应的值，让数码管变成对应的字母
					   break;
					 case(0x2): //U  1000001
					   Xil_Out8(XPAR_AXI_GPIO_1_BASEADDR+XGPIO_DATA2_OFFSET,0x41);
					   break;
					 case(0x4): //L  1000111
					   Xil_Out8(XPAR_AXI_GPIO_1_BASEADDR+XGPIO_DATA2_OFFSET,0x47);
					   break;
					 case(0x10): //D  1000000
					   Xil_Out8(XPAR_AXI_GPIO_1_BASEADDR+XGPIO_DATA2_OFFSET,0x40);
					   break;
					 case(0x8): //R  0001000
						Xil_Out8(XPAR_AXI_GPIO_1_BASEADDR+XGPIO_DATA2_OFFSET,0x08);
						break;
				   }
			}
		}
	}
}


