`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/09 16:28:21
// Design Name: 
// Module Name: instrsim
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


module instrsim(
  output [31:0] outaddr
    );
    reg [4:0] addr;
    
    instrmem  U1(addr,outaddr);
    initial
    begin
    addr=5'b00000;
    #20
    addr=5'b00001;
    #20
    addr=5'b00010;
    
    
    
    
    
    end
endmodule
