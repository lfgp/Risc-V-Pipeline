`timescale 1ns / 1ps

module HaltUnit (
    input logic [31:0] Instruction, // Instru��o atual no pipeline
    input logic [31:0] PC, // Contador de Programa (PC)
    output logic Halt, // Sinal de Halt para parar a execu��o
    output logic [31:0] Halt_PC // PC que ser� exibido quando o processador estiver parado
);

    // Definir a instru��o HALT (por exemplo, assumindo que HALT � 0xFFFF_FFFF)
    localparam [31:0] HALT_INSTRUCTION = 32'hFFFF_FFFF;

    // Verifica se a instru��o atual � HALT
    assign Halt = (Instruction == HALT_INSTRUCTION);

    // O PC � exibido quando o processador est� parado
    assign Halt_PC = (Halt) ? PC : 32'b0;

endmodule

