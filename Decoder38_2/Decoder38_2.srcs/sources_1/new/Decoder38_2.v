`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/16 17:13:40
// Design Name: 
// Module Name: Decoder38_2
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


module Decoder38_2 (data_out,data_in,enable) ;

input [2:0] data_in;

input enable;

output [7:0] data_out;

reg A=8'b0000_0001;

 

assign data_out=(enable)?((A<<data_in-1)):8'b1111_1111;

 

endmodule