`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 19:30:34
// Design Name: 
// Module Name: register
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


module register(
    input [4:0] Rsaddr,
    input [4:0] Rtaddr,
    input [4:0] wraddr,
    input RegWr,
    input [31:0] wrdata,
    input reset,
    input clk,
    output [31:0] Rsdata,
    output [31:0] Rtdata
    );
    
    reg [31:0] regs[0:31];
    integer i;
    assign Rsdata=(Rsaddr==5'b0)?32'b0:regs[Rsaddr];
    assign Rtdata=(Rtaddr==5'b0)?32'b0:regs[Rtaddr];
    
    always@(posedge clk)
    begin
    if(RegWr&!reset)
    regs[wraddr]<=wrdata;
    else if(reset)
      for(i=0;i<32;i=i+1)
         regs[i]=0;  
    end
    
endmodule
