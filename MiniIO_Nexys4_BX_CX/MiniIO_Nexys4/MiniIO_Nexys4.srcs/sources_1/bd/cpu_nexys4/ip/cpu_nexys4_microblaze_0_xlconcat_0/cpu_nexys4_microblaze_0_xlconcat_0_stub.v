// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu Jun  2 11:48:31 2022
// Host        : DESKTOP-70J5U7K running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/26254/Desktop/workDocs/vivado-projects/MiniIO_Nexys4/MiniIO_Nexys4.srcs/sources_1/bd/cpu_nexys4/ip/cpu_nexys4_microblaze_0_xlconcat_0/cpu_nexys4_microblaze_0_xlconcat_0_stub.v
// Design      : cpu_nexys4_microblaze_0_xlconcat_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "xlconcat_v2_1_1_xlconcat,Vivado 2017.4" *)
module cpu_nexys4_microblaze_0_xlconcat_0(In0, In1, In2, In3, In4, In5, In6, dout)
/* synthesis syn_black_box black_box_pad_pin="In0[0:0],In1[0:0],In2[0:0],In3[0:0],In4[0:0],In5[0:0],In6[0:0],dout[6:0]" */;
  input [0:0]In0;
  input [0:0]In1;
  input [0:0]In2;
  input [0:0]In3;
  input [0:0]In4;
  input [0:0]In5;
  input [0:0]In6;
  output [6:0]dout;
endmodule
