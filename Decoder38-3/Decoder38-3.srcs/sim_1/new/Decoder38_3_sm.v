`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/16 18:24:02
// Design Name: 
// Module Name: Decoder38_3_sm
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


module Decoder38_3_sm;

    // Inputs
    reg [2:0] data_in;
    reg enable;

    // Outputs
    wire [7:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    Decoder38_3 uut (
        .data_in(data_in), 
        .data_out(data_out), 
        .enable(enable)
    );

    initial begin
        // Initialize Inputs
        data_in = 0;
        enable = 1;

        // Wait 100 ns for global reset to finish
        #100;


        // Add stimulus here
        data_in <= 3'b000;
          #100;

          data_in <= 3'b001;
          #100;

          data_in <= 3'b010;
          #100;

          data_in <= 3'b011;
          #100;

          data_in <= 3'b100;
          #100;

          data_in <= 3'b101;
          #100;

          data_in <= 3'b110;
          #100;

          data_in <= 3'b111;





    end

endmodule
