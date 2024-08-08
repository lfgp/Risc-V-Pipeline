`timescale 1ns / 1ps

module BranchUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC,       // Contador de Programa atual
    input logic [31:0] Imm,              // Imediato calculado pela im_Gen
    input logic [31:0] AluResult,        // Resultado da ALU
    input logic Branch,                  // Sinal de ramifica��o
    input logic [2:0] BranchType,        // Tipo de ramifica��o (0: BNE, 1: BGE, 2: BLT)
    output logic [31:0] PC_Imm,          // Endere�o do PC para a ramifica��o
    output logic [31:0] PC_Four,         // PC+4
    output logic [31:0] BrPC,            // Endere�o de destino da ramifica��o
    output logic PcSel                    // Sele��o do PC (0: PC+4, 1: PC+Imm)
);

  logic Branch_Sel;

  assign PC_Four = {23'b0, Cur_PC} + 32'b100;
  assign PC_Imm = {23'b0, Cur_PC} + Imm;

  // Sele��o do Branch
  always_comb begin
    case (BranchType)
      3'b000: Branch_Sel = Branch && (AluResult != 0); // BNE
      3'b001: Branch_Sel = Branch && (AluResult >= 0); // BGE
      3'b010: Branch_Sel = Branch && (AluResult < 0);  // BLT
      default: Branch_Sel = 0;
    endcase
  end

  assign BrPC = (Branch_Sel) ? PC_Imm : 32'b0;
  assign PcSel = Branch_Sel;  // 1: branch is taken; 0: branch is not taken

endmodule

