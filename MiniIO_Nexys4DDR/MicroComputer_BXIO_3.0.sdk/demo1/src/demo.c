/*
 * main.c
 *
 *  Created on: 2022��5��26��
 *      Author: 26254
 */

//#include <xil_io.h>
//#include<stdio.h>
//#include <xgpio_l.h>
//int main()
//{
//	unsigned short last_sw,current_sw;
//	Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_TRI_OFFSET,0xffff);
//	Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_TRI2_OFFSET,0x0);
//	while(1)
//	{
//		last_sw=current_sw;
//		current_sw=Xil_In16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_DATA_OFFSET)&0xffff;
//		if(last_sw!=current_sw){
//			xil_printf("the switches' code is 0x%4x\n",current_sw);
//			Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_DATA2_OFFSET,current_sw);
//		}
//	}
//}


//#include <xil_io.h>
//#include <stdio.h>
//#include <xgpio_l.h>
//int main()
//{
//	unsigned short led;
//	unsigned char byte;
//	Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_TRI2_OFFSET,0x0);
//	while(1)
//	{
//		xil_printf("input the 16 bits hexadecimal number to be displayed:\r\n");
//		led=0;
//		while(1)
//		{
//			byte =inbyte();
//			if(byte==0x0d)
//			{
//				break;
//			}
//			else
//			{
//				if(byte>='a')
//					byte=byte-0x57;
//				else if(byte>='A')
//					byte=byte-0x37;
//				else
//					byte=byte-0x30;
//				led=(led<<4)+byte;
//
//			}
//
//		}
//		xil_printf("%x\n",led);
//		Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_DATA2_OFFSET,led);
//
//	}
//}



/*
 * control.c
 *
 *  Created on: 2022��5��21��
 *      Author: Alice
 */
#include "stdio.h"
#include "xil_io.h"
#include "xgpio_l.h"
int main()
{
	char button=0x0;
   	Xil_Out8(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_TRI_OFFSET,0x1f);//ͨ��GPIO_2��ͨ��0�Ŀ��ƼĴ����ĵ���λ����
    unsigned short last_sw,current_sw; //ͨ��״̬�ĸ��ķ�Ӧ�������
    Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_TRI_OFFSET,0xffff);//дGPIO_0ͨ��0�Ŀ��ƼĴ�����ʹ�����������뷽ʽ
	while(1)//���򷴸���ѯ
	{
	  while((Xil_In8(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_DATA_OFFSET)&0x1f)!=0) //ѭ����ⰴ���Ƿ��£���һ���������£��Ͳ��ǵ͵�ƽ,��������1������ѭ��
	   {
		button=Xil_In8(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_DATA_OFFSET)&0x1f;//�õ�����ֵ
		 while((Xil_In8(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_DATA_OFFSET)&0x1f)!=0)//�����ͷ�ʱ���ֵ
	     {
			switch(button)
		   {
		     case(0x1): //C  1000110
		       Xil_Out8(XPAR_AXI_GPIO_1_BASEADDR+XGPIO_DATA2_OFFSET,0x46);//�����Ӧ��ֵ��������ܱ�ɶ�Ӧ����ĸ
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
	    last_sw=current_sw;
	    current_sw=Xil_In16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_DATA_OFFSET)&0xffff;// current_sw����GPIO_0ͨ��0���ݼĴ�����ֵ
		if(last_sw!=current_sw)//�����ص�ֵ�����仯ʱ���ֵ
		 Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_DATA2_OFFSET,current_sw);//GPIO_0ͨ��2�����Ӧ��ֵ��������ӦLED

   }
}

