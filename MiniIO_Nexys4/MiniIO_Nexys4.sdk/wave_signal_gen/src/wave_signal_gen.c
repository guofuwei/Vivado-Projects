/*
 * wave_signal_gen.c
 *
 *  Created on: 2022��6��2��
 *      Author: 26254
 */
#include "xintc_l.h"
#include "xil_io.h"
#include "xtmrctr_l.h"
#include "xspi_l.h"
#include "xgpio.h"

short int samplePoint = 0; // ��ǰ������
int SET_VALUE = 500000;    // �������������ڣ�Ĭ��0.005s����Ӧ1Hz(1s ����� 200 ��������)
int frequency = 1;         // ��ǰ�趨��Ƶ��

int A = 4096;                   //�źŷ�ֵ
int scale[5] = {0, 0, 0, 0, 0}; //��Ӧ����ռ�ձ�
int wave = 0;                   //�Բ��ν���ѡ��

// 200 ��������� sin ��������
float Sin[] = {1.0, 1.0315685497648106, 1.0631056313126737, 1.094579807794845, 1.1259597050677175, 1.1572140429672508,
		1.1883116664897178, 1.2192215768476913, 1.2499129623703085, 1.2803552292170144, 1.3105180318741687, 1.3403713034041127,
		1.3698852854165469, 1.399030557732341, 1.4277780677102097, 1.456099159207016, 1.4839656011428386, 1.5113496156423267,
		1.5382239057242886, 1.564561682511918, 1.5903366919365283, 1.6155232409081792, 1.6400962229271072, 1.664031143110431,
		1.6873041426091842, 1.7098920223913328, 1.7317722663670767, 1.752923063833377, 1.7733233312153391, 1.7929527330827786,
		1.8117917024210208, 1.8298214601357259, 1.847024033772299, 1.8633822754312233, 1.8788798788614605, 1.893501395714874,
		1.9072322509454813, 1.9200587573381744, 1.9319681291524349, 1.9429484948674371, 1.9529889090158392, 1.9620793630944628,
		1.9702107955409862, 1.9773751007667073, 1.9835651372363698, 1.9887747345870026, 1.9929986997786697, 1.9962328222710068,
		1.9984738782203788, 1.999719633693478, 1.9999688468941563, 1.9992212694012756, 1.9974776464163386, 1.994739716020657,
		1.991010207442792, 1.9862928383380027, 1.980592311082404, 1.9739143080855377, 1.9662654861260218, 1.9576534697159296,
		1.9480868435005094, 1.937575143700825, 1.9261288486078412, 1.9137593681374367, 1.9004790324567518, 1.8863010796932087,
		1.8712396427384597, 1.8553097351604118, 1.8385272362373772, 1.8209088751292626, 1.802472214201578, 1.7832356315188904,
		1.7632183025251684, 1.7424401809292829, 1.7209219788147163, 1.6986851459933066, 1.6757518486236087, 1.6521449471151868,
		1.6278879733408584, 1.6030051071796145, 1.5775211524135886, 1.5514615120031077, 1.5248521627644684, 1.497719629475683,
		1.470090958436003, 1.441993690505579, 1.4134558336521341, 1.384505835032011, 1.3551725526334286, 1.3254852265102115,
		1.29547344963467, 1.2651671383986787, 1.2345965027923689, 1.2037920162901523, 1.1727843854740994, 1.1416045194249516,
		1.110283498911275, 1.0788525454074767, 1.0473429899715583, 1.0157862420136368, 0.984213757986363, 0.952657010028442,
		0.9211474545925237, 0.8897165010887251, 0.8583954805750482, 0.8272156145259004, 0.7962079837098479, 0.7654034972076313,
		0.7348328616013216, 0.7045265503653302, 0.6745147734897882, 0.6448274473665716, 0.6154941649679893, 0.5865441663478661,
		0.5580063094944211, 0.5299090415639969, 0.5022803705243168, 0.4751478372355318, 0.44853848799689267, 0.4224788475864115,
		0.3969948928203857, 0.37211202665914156, 0.34785505288481344, 0.3242481513763913, 0.30131485400669367, 0.2790780211852838,
		0.2575598190707168, 0.2367816974748318, 0.2167643684811097, 0.1975277857984219, 0.17909112487073753, 0.16147276376262254,
		0.14469026483958836, 0.12876035726154045, 0.11369892030679118, 0.09952096754324846, 0.08624063186256326, 0.07387115139215894,
		0.062424856299174936, 0.051913156499490354, 0.04234653028407054, 0.03373451387397808, 0.026085691914462306,
		0.019407688917595922, 0.013707161661997258, 0.008989792557207887, 0.005260283979342972, 0.002522353583661263,
		0.0007787305987243531, 3.1153105843673146e-05, 0.00028036630652206185, 0.0015261217796211923, 0.003767177728993265,
		0.0070013002213303865, 0.011225265412997398, 0.016434862763630043, 0.022624899233292806, 0.029789204459013674,
		0.03792063690553715, 0.047011090984160564, 0.05705150513256296, 0.06803187084756523, 0.07994124266182545,
		0.09276774905451868, 0.1064986042851257, 0.12112012113853965, 0.13661772456877674, 0.15297596622770104, 0.17017853986427423,
		0.18820829757897906, 0.20704726691722142, 0.2266766687846612, 0.24707693616662285, 0.2682277336329233, 0.2901079776086669,
		0.31269585739081573, 0.33596885688956835, 0.35990377707289267, 0.384476759091821, 0.4096633080634713, 0.4354383174880819,
		0.461776094275711, 0.4886503843576733, 0.5160343988571614, 0.5439008407929837, 0.5722219322897905, 0.6009694422676586,
		0.630114714583453, 0.6596286965958873, 0.6894819681258308, 0.7196447707829856, 0.7500870376296912, 0.7807784231523085,
		0.8116883335102824, 0.842785957032749, 0.8740402949322825, 0.9054201922051546, 0.9368943686873263, 0.9684314502351897,
		0.9999999999999998};

// �趨�жϷ������
void My_ISR() __attribute__((interrupt_handler));
void buttonHandler();
void timerHandler();
void swHandler();

int main()
{
    int tmp1, tmp2;
    // SPI_0 DA ģ���ʼ��
    //�趨SPIΪ���豸��CPOL=0,CPHA=1,�Զ���ʽ����λ���ȷ���
    Xil_Out32(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_CR_OFFSET, 0x16);
    //ѡ����豸
    Xil_Out32(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_SSR_OFFSET, 0xfffffffe);

    // INTC ģ���ʼ��
    // ������ͨ�жϷ�ʽ
    Xil_Out32(XPAR_INTC_0_BASEADDR + XIN_IMR_OFFSET, 0x0);
    // ��յ�ǰ INTC ģ���ж�״̬
    Xil_Out32(XPAR_INTC_0_BASEADDR + XIN_IAR_OFFSET, 0xffffffff);
    // �жϿ���������Դʹ��
    Xil_Out32(XPAR_INTC_0_BASEADDR + XIN_MER_OFFSET, 0x3);
    // ʹ�� GPIO0(����)��GPIO2(��ť)��Timer ���ж�����
    Xil_Out32(XPAR_INTC_0_BASEADDR + XIN_IER_OFFSET, 0x7);

    // Timer ģ���ʼ��
    // ֹͣ TIMER ��ʱ����ʱ
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET, Xil_In32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET) & ~XTC_CSR_ENABLE_TMR_MASK);
    // ��Ԥ��ֵ����TLR���趨��ʱ����
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TLR_OFFSET, SET_VALUE);
    // װ��Ԥ��ֵ
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET, Xil_In32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET) | XTC_CSR_LOAD_MASK);
    // �趨 TIMER ��ʱ����ʼ��ʱ���Զ���ȡ�������жϣ�������
    tmp1 = XTC_CSR_ENABLE_TMR_MASK | XTC_CSR_ENABLE_INT_MASK | XTC_CSR_DOWN_COUNT_MASK | XTC_CSR_AUTO_RELOAD_MASK;
    tmp2 = (Xil_In32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET) & ~XTC_CSR_LOAD_MASK) | tmp1;
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET, tmp2);

    // GPIO_0(����) ģ���ʼ��
    // ���ж�
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_ISR_OFFSET, 0x1);
    // ���� GPIO_0 ģ�� 16 λ����Ϊ����
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_TRI_OFFSET, 0xffff);
    // ���� GPIO_0 ģ�� 16 λ LED ������Ϊ���
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_TRI2_OFFSET, 0x0);
    // ʹ�� GPIO_0 ģ�����ж�����
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_GIE_OFFSET, 0x80000000);
    // ʹ�� GPIO_0 ģ��ͨ�� 0 16 λ�����ж�
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_IER_OFFSET, 0x1);

    // GPIO_2(��ť) ģ���ʼ��
    // ���ж�
    Xil_Out32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_ISR_OFFSET, 0x1);
    // ���� GPIO_2 ģ�� 5 ������Ϊ����
    Xil_Out32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_TRI_OFFSET, 0x1f);
    // ʹ�� GPIO_2 ģ�����ж�����
    Xil_Out32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_GIE_OFFSET, 0x80000000);
    //ʹ�� GPIO_2 ͨ�� 0 �ж�
    Xil_Out32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_IER_OFFSET, 0x1);

    // �����������ж�
    microblaze_enable_interrupts();
    // �������䣬��������0������DAת��
    Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, 0);
    return 0;
}

void My_ISR()
{
    int status;
    // XPAR_INTC_0_BASEADDR
    status = Xil_In32(XPAR_INTC_0_BASEADDR + XIN_ISR_OFFSET); // read ISR, ��ȡINTC�ж�״̬
    // �ж��ж�Դ
    // TIMER�ж�
    if ((status & XPAR_AXI_TIMER_0_INTERRUPT_MASK) == XPAR_AXI_TIMER_0_INTERRUPT_MASK)
        // ���붨ʱ���жϷ�����
        timerHandler();
    // GPIO_2(��ť) �ж�
    if ((status & XPAR_AXI_GPIO_2_IP2INTC_IRPT_MASK) == XPAR_AXI_GPIO_2_IP2INTC_IRPT_MASK)
        // ���밴ť�жϷ�����
        buttonHandler();
    // GPIO_0(����) �ж�
    if ((status & XPAR_AXI_GPIO_0_IP2INTC_IRPT_MASK) == XPAR_AXI_GPIO_0_IP2INTC_IRPT_MASK)
        // ���뿪���жϷ�����
        swHandler();
    // write IAR����� INTC ģ���ж�״̬
    Xil_Out32(XPAR_INTC_0_BASEADDR + XIN_IAR_OFFSET, status);
}

void timerHandler()
{
    // ���㵱ǰ��Ҫ����Ĳ�����
    samplePoint = (samplePoint + 1) % 200;
    // ���ݲ��ξ��������ʽ
    switch (wave)
    {
    case 0x1:
    { //���Ҳ�
        // �����Ӧ�������źŲ���������
        Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, (int)(((A - 1) * Sin[samplePoint]) / 4.0));
        break;
    }

    case 0x2:
    { //���ǲ�
        if (samplePoint <= 100)
            Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, (A - 1) * samplePoint / 100 / 2);
        else
            Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, (A - A * (samplePoint - 100) / 100) / 2);
        break;
    }

    case 0x4:
    { //������
        // ռ�ձ��л�
        if (scale[0])
        {
            // ռ�ձ� 10%��200 ���������н�ǰ 20 �������ѹ
            if (samplePoint < 20)
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, A / 2);
            else
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, 0x0);
            break;
        }
        else if (scale[1])
        {
            // ռ�ձ� 25%��200 ���������н�ǰ 50 �������ѹ
            if (samplePoint < 50)
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, A / 2);
            else
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, 0x0);
            break;
        }
        else if (scale[2])
        {
            // ռ�ձ� 50%��200 ���������н�ǰ 100 �������ѹ
            if (samplePoint < 100)
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, A / 2);
            else
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, 0x0);
            break;
        }
        else if (scale[3])
        {
            // ռ�ձ� 75%��200 ���������н�ǰ 150 �������ѹ
            if (samplePoint < 150)
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, A / 2);
            else
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, 0x0);
            break;
        }
        else if (scale[4])
        {
            // ռ�ձ� 90%��200 ���������н�ǰ 180 �������ѹ
            if (samplePoint < 180)
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, A / 2);
            else
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, 0x0);
            break;
        }
        else
        {
            // ռ�ձ� 50%��200 ���������н�ǰ 100 �������ѹ
            if (samplePoint < 100)
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, A / 2);
            else
                Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, 0x0);
            break;
        }
    }

    case 0x8:
    { //��ݲ�
        Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, samplePoint * (A - 1) / 200 / 2);
        break;
    }

    default:
        Xil_Out16(XPAR_AXI_QUAD_SPI_0_BASEADDR + XSP_DTR_OFFSET, 0); //Ĭ��Ϊ0
    }
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET, Xil_In32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET)); //TIMER���ж�
}

void swHandler()
{
    // ��ȡ�� 4 λ���أ���Ϊ���ο����ź�
    wave = Xil_In16(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_DATA_OFFSET) & 0xf;
    // ռ�ձ� 10%
    scale[0] = (Xil_In16(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_DATA_OFFSET) & 0x20) == 0x20;
    // ռ�ձ� 25%
    scale[1] = (Xil_In16(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_DATA_OFFSET) & 0x40) == 0x40;
    // ռ�ձ� 50%
    scale[2] = (Xil_In16(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_DATA_OFFSET) & 0x80) == 0x80;
    // ռ�ձ� 75%
    scale[3] = (Xil_In16(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_DATA_OFFSET) & 0x100) == 0x100;
    // ռ�ձ� 90%
    scale[4] = (Xil_In16(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_DATA_OFFSET) & 0x200) == 0x200;
    // ����״̬ͬ���� LED ��
    Xil_Out16(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_DATA2_OFFSET, Xil_In16(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_DATA_OFFSET));
    // GPIO_0 ���ж�
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_ISR_OFFSET, Xil_In32(XPAR_AXI_GPIO_0_BASEADDR + XGPIO_ISR_OFFSET));
}

void buttonHandler()
{
    int button = Xil_In32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_DATA_OFFSET) & 0xf; //��ȡ����״̬

    switch (button) // �жϰ��°���
    {
    case (0x2): // BTNU������1hzƵ��
    {
        frequency = frequency + 1;
        SET_VALUE = (int)(1000000 / (2 * frequency));
        // ������Ҫ�����ÿ����������ʱ��
        xil_printf("frequency=%d\n\r", frequency);
        break;
    }

    case (0x1): // BTNC����СƵ��1hz
    {
        frequency = frequency - 1;
        // ���ֻ������� 1Hz �ź�
        if (frequency < 1)
        {
            frequency = 1;
        }
        // ������Ҫ�����ÿ����������ʱ��
        SET_VALUE = (int)(1000000 / (2 * frequency));
        xil_printf("frequency=%d\n\r", frequency);
        break;
    }

    case (0x4): // BTNL�������ֵ0.1V
    {
        A += 248;
        break;
    }

    case (0x8): // BTNR����С��ֵ0.1V
    {
        A -= 248;
        break;
    }
    }

    // Timer ģ���ʼ��
    // ֹͣ TIMER ��ʱ����ʱ
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET, Xil_In32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET) & ~XTC_CSR_ENABLE_TMR_MASK);
    // ��Ԥ��ֵ����TLR���趨��ʱ����
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TLR_OFFSET, SET_VALUE);
    // װ��Ԥ��ֵ
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET, Xil_In32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET) | XTC_CSR_LOAD_MASK);
    // �趨 TIMER ��ʱ����ʼ��ʱ���Զ���ȡ�������жϣ�������
    int tmp1 = XTC_CSR_ENABLE_TMR_MASK | XTC_CSR_ENABLE_INT_MASK | XTC_CSR_DOWN_COUNT_MASK | XTC_CSR_AUTO_RELOAD_MASK;
    int tmp2 = (Xil_In32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET) & ~XTC_CSR_LOAD_MASK) | tmp1;
    Xil_Out32(XPAR_AXI_TIMER_0_BASEADDR + XTC_TCSR_OFFSET, tmp2);

    // GPIO_2 ���ж�
    Xil_Out32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_ISR_OFFSET, Xil_In32(XPAR_AXI_GPIO_2_BASEADDR + XGPIO_ISR_OFFSET));
}