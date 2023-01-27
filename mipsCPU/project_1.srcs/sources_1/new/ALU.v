`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 20:04:12
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [3:0] ALUCtr,
    input signed [31:0]  input1,
    input  signed [31:0]  input2,
    output reg [31:0] res,
    output reg zero
    );
    always@(input1 or input2 or ALUCtr)
    begin
    case(ALUCtr)
    4'b0010://add
    begin
    res=input1+input2;
    zero=0;
    end
    4'b0110://sub
    begin
       res=input1-input2;
       zero=(res==0)?1:0;
    end
    4'b0000://and
    begin
          res=input1&input2;
          zero=0;
    end
    4'b0001://or
    begin
          res=input1|input2;
          zero=0;
     end
    4'b0111://slt
     begin
          res=(input1<input2)?1:0;
          zero=0;
     end
    default:
     begin
     res=32'b0;
     zero=0;
     end
    endcase
      
    end
     
endmodule
