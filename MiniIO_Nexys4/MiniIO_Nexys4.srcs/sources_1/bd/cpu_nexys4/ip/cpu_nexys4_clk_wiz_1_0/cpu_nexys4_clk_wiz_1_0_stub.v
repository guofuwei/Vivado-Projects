// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sun May 29 20:59:09 2022
// Host        : DESKTOP-70J5U7K running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/26254/Desktop/workDocs/vivado-projects/MiniIO_Nexys4/MiniIO_Nexys4.srcs/sources_1/bd/cpu_nexys4/ip/cpu_nexys4_clk_wiz_1_0/cpu_nexys4_clk_wiz_1_0_stub.v
// Design      : cpu_nexys4_clk_wiz_1_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module cpu_nexys4_clk_wiz_1_0(clk_out1, resetn, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,resetn,locked,clk_in1" */;
  output clk_out1;
  input resetn;
  output locked;
  input clk_in1;
endmodule
