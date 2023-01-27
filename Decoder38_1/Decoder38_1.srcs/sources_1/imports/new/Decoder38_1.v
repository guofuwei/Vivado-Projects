`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/16 17:09:58
// Design Name: 
// Module Name: Decoder38_1
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


module Decoder38_1(data_in,data_out,enable);
    input [2:0] data_in;
     input enable;
     output [7:0] data_out;
     reg [7:0] data_out;

always @(data_in)
    begin
         if (enable == 1)
            case(data_in)
                  3'b000: data_out = 8'b00000001;
                  3'b001: data_out = 8'b00000010;
                  3'b010: data_out = 8'b00000100;
                  3'b011: data_out = 8'b00001000;
                  3'b100: data_out = 8'b00010000;
                  3'b101: data_out = 8'b00100000;
                  3'b110: data_out = 8'b01000000;
                  3'b111: data_out = 8'b10000000;
                  default: data_out = 8'bxxxxxxxx;
              endcase
            else
                data_out = 8'b11111111;

     end         
endmodule
