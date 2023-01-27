`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 19:42:17
// Design Name: 
// Module Name: regsim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module regsim(
    output [31:0] Rsdata,
    output [31:0] Rtdata
    );
    reg [4:0] Rsaddr;
    reg [4:0] Rtaddr;
    reg [4:0] wraddr;
    reg RegWr;
    reg [31:0] wrdata;
    reg reset;
    reg clk;
    
    
   parameter PERIOD = 10;
   
      always begin
         clk = 1'b0;
         #(PERIOD/2) clk = 1'b1;
         #(PERIOD/2);
      end
      
      initial 
      begin
      reset=1;
      Rsaddr=5'h0;
      Rtaddr=5'h0;
      #15
      reset=0;
      #30
      RegWr=1;
      wraddr=5'h03;
      wrdata=32'h5aa3;
      #20
      Rsaddr=5'h03;
      Rtaddr=5'h04;
      #30
        wraddr=5'h04;
        wrdata=32'h5ba3;
       #20
       Rsaddr=5'h03;
       Rtaddr=5'h04;
       #20
       reset=1;
       end
      register  U0(Rsaddr,Rtaddr,wraddr,RegWr,wrdata,reset,clk,Rsdata,Rtdata);
      
endmodule
