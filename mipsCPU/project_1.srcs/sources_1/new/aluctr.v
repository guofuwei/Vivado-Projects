`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 21:07:09
// Design Name: 
// Module Name: aluctr
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


module aluctr(
    input [1:0] ALUop,
    input [5:0] func,
    output reg [3:0] ALUctr
    );
    always@(ALUop or func)
    casex({ALUop,func})
    8'b00xx_xxxx:ALUctr=4'b0010;//lw,sw,addi
    8'b01xx_xxxx:ALUctr=4'b0110;//beq
    8'b10xx_0000:ALUctr=4'b0010;//add
    8'b10xx_0010:ALUctr=4'b0110;//sub
    8'b10xx_0100:ALUctr=4'b0000;//add
    8'b10xx_0101:ALUctr=4'b0001;//or
    8'b10xx_1010:ALUctr=4'b0111;//slt
    default: ALUctr=4'b0000;
    endcase
endmodule
