/*
 * BXIO_task1_intr.c
 *
 *  Created on: 2022��5��29��
 *      Author: 26254
 */
#include "xtmrctr_l.h"
#include "xintc_l.h"
#include "xil_io.h"
#include "xgpio.h"
#define RESET_VALUE 10000
void My_ISR() __attribute__((interrupt_handler));
short pos=0xff7f;
//char scancode[5][2]={{0x1,0xc6},{0x2,0xc1},{0x4,0xc7},{0x8,0x88},{0x10,0xa1}};
char scancode[5][2]={{0x1,0xc1},{0x2,0xc7},{0x4,0xa1},{0x8,0x88},{0x10,0xc6}};
// C U L A D
char segcode[8]={0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
int i=0;
void switch_handle();
void button_handle();
void seg_timer();
int main()
{

    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_TRI_OFFSET, 0xffffffff);
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_TRI2_OFFSET, 0x00000000);
	Xil_Out32(XPAR_AXI_GPIO_1_BASEADDR + XGPIO_TRI_OFFSET, 0x00000000);
	Xil_Out32(XPAR_AXI_GPIO_1_BASEADDR + XGPIO_TRI2_OFFSET, 0x00000000);
    Xil_Out32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_TRI_OFFSET, 0xffffffff);

    Xil_Out32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_ISR_OFFSET, XGPIO_IR_CH1_MASK);
    Xil_Out32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_IER_OFFSET, XGPIO_IR_CH1_MASK);
    Xil_Out32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_GIE_OFFSET, XGPIO_GIE_GINTR_ENABLE_MASK);

    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_ISR_OFFSET, XGPIO_IR_CH1_MASK);
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_IER_OFFSET, XGPIO_IR_CH1_MASK);
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_GIE_OFFSET, XGPIO_GIE_GINTR_ENABLE_MASK);

    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET, Xil_In32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET) & ~XTC_CSR_ENABLE_TMR_MASK);
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TLR_OFFSET, RESET_VALUE);
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET, Xil_In32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET) | XTC_CSR_LOAD_MASK);
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET,
    		(Xil_In32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET) & ~XTC_CSR_LOAD_MASK) | XTC_CSR_ENABLE_TMR_MASK | XTC_CSR_AUTO_RELOAD_MASK | XTC_CSR_ENABLE_INT_MASK | XTC_CSR_DOWN_COUNT_MASK);

    Xil_Out32(XPAR_INTC_SINGLE_BASEADDR + XIN_IAR_OFFSET, 0xffffffff);
    //Xil_Out32(XPAR_INTC_SINGLE_BASEADDR+XIN_IMR_OFFSET,XPAR_AXI_GPIO_2_IP2INTC_IRPT_MASK|XPAR_AXI_TIMER_0_INTERRUPT_MASK);
    Xil_Out32(XPAR_INTC_SINGLE_BASEADDR + XIN_IER_OFFSET, /*XPAR_AXI_GPIO_2_IP2INTC_IRPT_MASK|XPAR_AXI_TIMER_0_INTERRUPT_MASK*/ 0x7);
    Xil_Out32(XPAR_INTC_SINGLE_BASEADDR + XIN_MER_OFFSET, /*XPAR_AXI_GPIO_2_IP2INTC_IRPT_MASK|XPAR_AXI_TIMER_0_INTERRUPT_MASK*/ 0x3);
    microblaze_enable_interrupts();
    return 0;
}
void My_ISR()
{
    int status;
    status = Xil_In32(XPAR_INTC_0_BASEADDR + XIN_ISR_OFFSET);
    if ((status & XPAR_AXI_TIMER_0_INTERRUPT_MASK) == XPAR_AXI_TIMER_0_INTERRUPT_MASK)
    	seg_timer();
    if ((status & XPAR_AXI_GPIO_0_IP2INTC_IRPT_MASK) == XPAR_AXI_GPIO_0_IP2INTC_IRPT_MASK)
    	switch_handle();
    if ((status & XPAR_AXI_GPIO_2_IP2INTC_IRPT_MASK) == XPAR_AXI_GPIO_2_IP2INTC_IRPT_MASK)
    	button_handle();
    Xil_Out32(XPAR_INTC_0_BASEADDR + XIN_IAR_OFFSET, status);
}

void switch_handle()
{
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_DATA2_OFFSET,Xil_In32(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_DATA_OFFSET));
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_ISR_OFFSET,Xil_In32(XPAR_AXI_GPIO_0_BASEADDR+XGPIO_ISR_OFFSET));
}

void seg_timer()
{
	Xil_Out8(XPAR_AXI_GPIO_1_BASEADDR+XGPIO_DATA2_OFFSET,segcode[i]);
	Xil_Out8(XPAR_AXI_GPIO_1_BASEADDR+XGPIO_DATA_OFFSET,pos);
	pos=pos>>1;
	i++;
	if(i==8){
		i=0;
		pos=0xff7f;
	}
	Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR+XTC_TCSR_OFFSET,Xil_In32(XPAR_AXI_TIMER_0_BASEADDR+XTC_TCSR_OFFSET));
}

void button_handle(){
	int btncode,index,j;
	btncode=Xil_In32(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_DATA_OFFSET);
	for(index=0;index<5;index++){
		if(btncode==scancode[index][0])
		{
//			for(j=0;j<7;j++)
//			{
//				segcode[j]=segcode[j+1];
//			}
//			segcode[7]=scancode[index][1];
			xil_printf("%x\n",index);
			for(j=0;j<8;j++)
			{
				segcode[j]=scancode[index][1];
			}
			break;
		}
	}
	Xil_Out32(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_ISR_OFFSET,Xil_In32(XPAR_AXI_GPIO_2_BASEADDR+XGPIO_ISR_OFFSET));
}

