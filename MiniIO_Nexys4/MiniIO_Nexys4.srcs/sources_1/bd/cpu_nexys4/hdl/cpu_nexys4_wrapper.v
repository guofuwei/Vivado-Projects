//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Thu Jun  9 15:32:17 2022
//Host        : DESKTOP-70J5U7K running 64-bit major release  (build 9200)
//Command     : generate_target cpu_nexys4_wrapper.bd
//Design      : cpu_nexys4_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module cpu_nexys4_wrapper
   (MISO,
    MOSI,
    SCLK0,
    SCLK1,
    SS0,
    SS1,
    dip_switches_16bits_tri_i,
    dual_seven_seg_led_disp_tri_o,
    led_16bits_tri_o,
    push_buttons_5bits_tri_i,
    reset,
    rgb_led_tri_o,
    seven_seg_led_an_tri_o,
    sys_clock,
    uart1_recv,
    uart1_send,
    uart2_recv,
    uart2_send,
    usb_uart_rxd,
    usb_uart_txd);
  input MISO;
  output MOSI;
  output SCLK0;
  output SCLK1;
  output [0:0]SS0;
  output [0:0]SS1;
  input [15:0]dip_switches_16bits_tri_i;
  output [7:0]dual_seven_seg_led_disp_tri_o;
  output [15:0]led_16bits_tri_o;
  input [4:0]push_buttons_5bits_tri_i;
  input reset;
  output [5:0]rgb_led_tri_o;
  output [7:0]seven_seg_led_an_tri_o;
  input sys_clock;
  input uart1_recv;
  output uart1_send;
  input uart2_recv;
  output uart2_send;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire MISO;
  wire MOSI;
  wire SCLK0;
  wire SCLK1;
  wire [0:0]SS0;
  wire [0:0]SS1;
  wire [15:0]dip_switches_16bits_tri_i;
  wire [7:0]dual_seven_seg_led_disp_tri_o;
  wire [15:0]led_16bits_tri_o;
  wire [4:0]push_buttons_5bits_tri_i;
  wire reset;
  wire [5:0]rgb_led_tri_o;
  wire [7:0]seven_seg_led_an_tri_o;
  wire sys_clock;
  wire uart1_recv;
  wire uart1_send;
  wire uart2_recv;
  wire uart2_send;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  cpu_nexys4 cpu_nexys4_i
       (.MISO(MISO),
        .MOSI(MOSI),
        .SCLK0(SCLK0),
        .SCLK1(SCLK1),
        .SS0(SS0),
        .SS1(SS1),
        .dip_switches_16bits_tri_i(dip_switches_16bits_tri_i),
        .dual_seven_seg_led_disp_tri_o(dual_seven_seg_led_disp_tri_o),
        .led_16bits_tri_o(led_16bits_tri_o),
        .push_buttons_5bits_tri_i(push_buttons_5bits_tri_i),
        .reset(reset),
        .rgb_led_tri_o(rgb_led_tri_o),
        .seven_seg_led_an_tri_o(seven_seg_led_an_tri_o),
        .sys_clock(sys_clock),
        .uart1_recv(uart1_recv),
        .uart1_send(uart1_send),
        .uart2_recv(uart2_recv),
        .uart2_send(uart2_send),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
