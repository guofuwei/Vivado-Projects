`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 20:52:26
// Design Name: 
// Module Name: mainctr
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


module mainctr(
    input [5:0] opcode,
    output [1:0] ALUop,
    output RtDst,
    output regwr,
    output Imm,
    output memwr,
    output B,
    output J,
    output M2R
    );
    reg [8:0] outtemp;
    assign RtDst=outtemp[8];
    assign Imm=outtemp[7];
    assign M2R=outtemp[6];
    assign regwr=outtemp[5];
    assign memwr=outtemp[4];
    assign B=outtemp[3];
    assign J=outtemp[2];
    assign ALUop=outtemp[1:0];
    always@(opcode)
    begin
    case(opcode)
    6'b000010: outtemp=9'bxxx0_001x_x;//jmp
    6'b000000: outtemp=9'b1001_0001_0;//R
    6'b100011: outtemp=9'b0111_0000_0;//lw
    6'b101011: outtemp=9'bx1x0_1000_0;//sw
    6'b000100: outtemp=9'bx0x0_0100_1;//beq
    6'b001000: outtemp=9'b0101_0000_0;//addi
    default: outtemp=9'b0000_0000_0;
    endcase
    end
    
endmodule
