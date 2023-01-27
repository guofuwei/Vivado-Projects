`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/16 18:13:27
// Design Name: 
// Module Name: Decoder38_3
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

module Decoder38_3 (data_out,data_in,enable) ;

input [2:0] data_in;

input enable;

output [7:0] data_out;

reg [7:0] data_out;

 

always @(data_in or enable)

begin

      if (enable==1)

             if(data_in==3'b000)

data_out=8'b00000001;

             else if(data_in==3'b001)

data_out=8'b00000010;

             else if(data_in==3'b010)

data_out=8'b00000100;

             else if(data_in==3'b011)

data_out=8'b00001000;

             else if(data_in==3'b100)

data_out=8'b00010000;

             else if(data_in==3'b101)

data_out=8'b00100000;

             else if(data_in==3'b110)

data_out=8'b01000000;

             else if(data_in==3'b111)

data_out=8'b10000000;

             else

data_out=8'bxxxxxxxx;

      else

             data_out = 8'b11111111;
             
end
endmodule