`timescale 1ns / 1ps

module StoreFunction (
    input logic clk,
    input logic MemWrite,    // Sinal de escrita na mem�ria
    input logic [31:0] addr, // Endere�o de escrita
    input logic [31:0] write_data, // Dados a serem escritos
    input logic [2:0] funct3 // Campo Funct3 da instru��o
);

    // Inst�ncia do m�dulo datamemory
    datamemory #(
        .DM_ADDRESS(9),
        .DATA_W(32)
    ) mem_inst (
        .clk(clk),
        .MemRead(1'b0),      // Sem opera��o de leitura
        .MemWrite(MemWrite), // Ativa opera��o de escrita
        .a(addr[8:0]),       // Endere�o para escrita
        .wd(write_data),     // Dados a serem escritos
        .Funct3(funct3),
        .rd()                // Sa�da de leitura n�o usada
    );

    always_ff @(posedge clk) begin
        if (MemWrite) begin
            case (funct3)
                3'b000: begin // SB
                    // Escreve apenas o byte menos significativo
                    // Considerando a estrutura do `datamemory`, escrevemos no bloco de mem�ria apropriado
                    mem_inst.Wr <= 4'b0001 << (addr[1:0]); // Seleciona o banco apropriado
                    mem_inst.Datain <= {24'b0, write_data[7:0]}; // Apenas o byte menos significativo � usado
                end
                3'b001: begin // SH
                    // Escreve os 16 bits menos significativos
                    // Considerando a estrutura do `datamemory`, escrevemos nos dois blocos de mem�ria apropriados
                    mem_inst.Wr <= (addr[1:0] == 2'b00) ? 4'b0011 : 4'b1100; // Seleciona os bancos apropriados
                    mem_inst.Datain <= {16'b0, write_data[15:0]}; // Apenas os 16 bits menos significativos s�o usados
                end
                default: begin
                    // Caso padr�o, sem opera��o de escrita
                    mem_inst.Wr <= 4'b0000;
                    mem_inst.Datain <= 32'b0;
                end
            endcase
        end
    end

endmodule

