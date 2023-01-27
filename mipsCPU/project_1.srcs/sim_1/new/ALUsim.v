`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 20:12:43
// Design Name: 
// Module Name: ALUsim
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


module ALUsim(
    output  [31:0] res,
    output  zero
    );
    reg [31:0] in1,in2;
    reg[3:0]ALUCtr;
    
   ALU U0(ALUCtr,in1,in2,res,zero);

    initial
    begin
 
    in1=32'hffff0006;
    in2=32'h00000001;
    ALUCtr=4'b0010;
    #30
    ALUCtr=4'b0110;
    #30
    ALUCtr=4'b0000;
     #30
    ALUCtr=4'b0001;
     #30
    ALUCtr=4'b0111;
    end
   
endmodule
