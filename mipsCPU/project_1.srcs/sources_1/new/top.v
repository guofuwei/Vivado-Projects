`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 21:21:54
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input reset
    );
    wire [31:0] TempPC,MuxPC,JumpPC,BranchPC,SquencePC,Imm32,ImmL2,RegWD,RsData,RtData,ALUIn2,ALURes,MemRD,Instr;
    wire [4:0] RegWA;
    wire [27:0] PsudeoPC;
    wire BranchZ,J,B,Zero,RegDst,RegWr,ALUSrc,MemWR,Mem2Reg;
    wire [1:0] ALUop;
    wire [3:0] ALUCtr;
    reg [31:0] PC;
    assign PsudeoPC={Instr[25:0],2'b00};
    assign JumpPC={SquencePC[31:28],PsudeoPC};
    assign SquencePC=PC+4;
    assign BranchPC=ImmL2+SquencePC;
    assign MuxPC=BranchZ?BranchPC:SquencePC;
    assign TempPC=J?JumpPC:MuxPC;
    assign BranchZ=B&Zero;
    assign ImmL2={Imm32[29:0],2'b00};
    assign Imm32={Instr[15]?16'hffff:16'h0,Instr[15:0]};
    assign ALUIn2=ALUSrc?Imm32:RtData;
    assign RegWA=RegDst?Instr[15:11]:Instr[20:16];
    assign RegWD=Mem2Reg?MemRD:ALURes;
    ALU UnitALU(ALUCtr,RsData,ALUIn2,ALURes,Zero);
    datamem UnitDataMem(~clk,ALURes[6:2],MemWR,RtData,MemRD);
    instrmem UnitInstrMen(PC[6:2],Instr);
    register UnitReg(Instr[25:21],Instr[20:16],RegWA,RegWr,RegWD,reset,~clk,RsData,RtData);
    mainctr UNitMainCtr(Instr[31:26],ALUop,RegDst,RegWr,ALUSrc,MemWR,B,J,Mem2Reg);
    aluctr UnitALUCtr(ALUop,Instr[5:0],ALUCtr);
    always@(posedge clk)
    begin
    if(reset)
    PC<=0;
    else
    PC<=TempPC;
    end   
endmodule
