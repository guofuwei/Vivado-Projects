`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 20:39:24
// Design Name: 
// Module Name: instrmem
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


module instrmem(
    input [4:0] addr,
    output [31:0] outaddr
    );
    reg [31:0] regs[0:31];
    assign outaddr=regs[addr];
    initial
    begin
    $readmemh("C:/Users/26254/Desktop/workDocs/vivado-projects/test.txt",regs,0,11);
    end

endmodule
