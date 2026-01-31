`timescale 1ns/1ns
module MIPS_tb;

reg clock;
reg reset;
wire signed [31:0] V0, A0;

//Clock
always #5 clock = ~clock;

//instância do processador
MIPS processador(clock, reset, V0, A0);

integer i;

initial begin
    
    //Geração do arquivo .vcd
    $dumpfile("MIPS.vcd");
    $dumpvars(0,MIPS_tb);

    //Captura dos valores de V0 e A0 a qualquer mudança que ocorre neles
    //$monitor("Valor em V0: %d",V0);
    $monitor("Valor em A0: %d", A0);
    //UTILIZE A LINHA ABAIXO PARA MONITORAR INSTRUÇÃO A INSTRUÇÃO 
   //$monitor("Tempo: %0t | PC: %d | Instr: %h | V0: %d | A0: %d", $time, processador.progCounter.value, processador.instruction, V0, A0); 
    for(i = 0; i< 256; i = i +1) begin
        $dumpvars(0, processador.mem.dataMemory[i]);
    end

    for(i = 0; i< 32; i = i + 1) begin
        $dumpvars(0, processador.registerBank.regs[i]);
    end 
    #10

    //clock inicializado em 0, e reset para zerar qualquer valor
    clock = 0;
    reset = 1;
    #5
    reset = 0;
    #5

    #2000
    $finish;
end

//verifica, a cada ciclo de clock, se o valor de V0 é 10 (Código de syscall para encerrar o programa)
always @(posedge clock) begin
    if(V0 == 10) begin
        $display("valor final em A0 (posição no Array): %d", A0);
        if(A0 == -1) begin
            $display("   (Não encontrado)");
        end
        $finish;
    end

end


endmodule