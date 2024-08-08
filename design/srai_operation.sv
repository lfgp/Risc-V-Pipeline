module srai_operation #(
    parameter DATA_WIDTH = 32,
    parameter OPCODE_LENGTH = 4
    ) (
    input logic [DATA_WIDTH-1:0]    SrcA,       // Registrador Rs1
    input logic [DATA_WIDTH-1:0]    Immediate,  // Valor imediato (n�mero de posi��es de deslocamento)
    output logic [DATA_WIDTH-1:0]   Rd          // Registrador de destino
    );

    // Sinal de controle da ALU para a opera��o de Shift Right Arithmetic
    logic [OPCODE_LENGTH-1:0] ALUControl;
    logic [DATA_WIDTH-1:0] ALUResult;  // Resultado da ALU

    // Configurando a ALU para realizar a opera��o SRA (Shift Right Arithmetic)
    assign ALUControl = 4'b1011; // C�digo de controle para Shift Right Arithmetic (SRA)

    // Instanciando a ALU
    alu #(
        .DATA_WIDTH(DATA_WIDTH),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) alu_inst (
        .SrcA(SrcA),
        .SrcB(Immediate),
        .Operation(ALUControl),
        .ALUResult(ALUResult)
    );

    // O resultado da opera��o SRAI � armazenado no registrador de destino
    assign Rd = ALUResult;

endmodule

