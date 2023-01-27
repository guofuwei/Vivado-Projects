`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/06 20:16:22
// Design Name: 
// Module Name: topsim
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


module topsim(
   
    );
    reg clk,reset;
    top  u0(clk,reset);
    
    parameter PERIOD = 10;
    
       always begin
          clk = 1'b0;
          #(PERIOD/2) clk= 1'b1;
          #(PERIOD/2);
       end
       initial
       begin
       reset=1;
       #20
       reset=0;
       end
                    
    
    
endmodule
