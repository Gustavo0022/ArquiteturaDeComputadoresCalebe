`timescale 1ns/1ns

module somador32bit_tb;

    reg[31:0] a,b;
    wire[32:0] s;

    somador32bit DUT (
        a, b, s[31:0], s[32]
    );

    initial begin
        $dumpfile("somador32bit_tb.vcd");
        $dumpvars(0, somador32bit_tb);
    end

    initial begin


    for(a = 0; a<16384; a = a+1) begin
        $display("Testando: a= %b", a);
        for(b=0; b<16384; b = b+1) begin
            #10;
        end
    end

    end


    reg [32:0] expected_sum;
       always @(a, b) begin
        expected_sum = a + b; // modelo de referencia. Calcula o resultado correto.
        #1; // Aguardar tempo suficiente para o DUT processar os sinais
        if (s === expected_sum) begin
        end else begin
            $display("ERRO: a = %b e b = %b: esperado = %b, obtido = %b", a, b, expected_sum, s);
        end
    end

    endmodule