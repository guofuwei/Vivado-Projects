`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 20:43:39
// Design Name: 
// Module Name: datamem
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


module datamem(
    input clk,
    input [4:0] addr,
    input memwr,
    input [31:0] writedata,
    output [31:0] readdata
    );
    reg [31:0] regs[0:31];
    assign readdata=regs[addr];
   // always@(addr or writedata or memwr)
   always@(negedge clk)
    if(memwr)
    regs[addr]=writedata;
   integer i;
   initial
   for(i=0;i<32;i=i+1)
   regs[i]=i;
   
    
endmodule
