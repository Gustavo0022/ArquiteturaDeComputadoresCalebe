`timescale 1ns/1ns
//`include "somador8bit.v"

module somador8bit_tb;

    reg[7:0] a,b;
    wire[8:0] s;

    somador8bit DUT (
        .Sum(s[7:0]), .A(a), .B(b), .Cin(1'b0), .Cout(s[8])
    );

    initial begin
        $dumpfile("somador8bit_tb.vcd");
        $dumpvars(0, somador8bit_tb);
    end

    initial begin


    a= 8'b00000000;
        repeat (256) begin
            $display("Gerando estimulos: valores de b para a = %b", a);
            repeat (256) begin
                #10; // Esperar 10 unidades de tempo
                b = b + 1;
            end
            b = 8'b00000000; // Resetar b
            a = a + 1;
        end
        ///// ATE AQUI
        // Finaliza a simulação
        #10;
        $finish;
    end

  


    reg [8:0] expected_sum;

       always @(a, b) begin
        expected_sum = a + b; // modelo de referencia. Calcula o resultado correto.
        #1; // Aguardar tempo suficiente para o DUT processar os sinais
        if (s === expected_sum) begin
            //$display("OKAY: a = %b e b = %b", a, b); // habilite e veja ficar lento. :)
            // Na real, interessa imprimir apenas se der erro. Se tá certinho, segue o baile.
        end else begin
            $display("ERRO: a = %b e b = %b: esperado = %b, obtido = %b", a, b, expected_sum, s);
        end
    end

endmodule