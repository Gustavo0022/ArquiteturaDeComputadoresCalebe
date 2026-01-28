`timescale 1ns/1ns
module MIPS_tb;

reg clock;
reg reset;
wire signed [31:0] V0, A0;

always #5 clock = ~clock;

MIPS processador(clock, reset, V0, A0);

integer i;

initial begin
    
    $dumpfile("MIPS.vcd");
    $dumpvars(0,MIPS_tb);

    
    $monitor("Valor em V0: %d",V0);
    $monitor("Valor em A0: %d", A0);
    //UTILIZE A LINHA ABAIXO PARA MONITORAR INSTRUÇÃO A INSTRUÇÃO 
   //$monitor("Tempo: %0t | PC: %d | Instr: %h | V0: %d | A0: %d", $time, processador.progCounter.value, processador.instruction, V0, A0); 
    for(i = 0; i< 256; i = i +1) begin
        $dumpvars(0, processador.mem.mem[i]);
    end

    for(i = 0; i< 32; i = i + 1) begin
        $dumpvars(0, processador.registerBank.regs[i]);
    end 
    #10

    clock = 0;
    reset = 1;
    #5
    reset = 0;
    #5

    #2000
    $finish;
end


always @(posedge clock) begin
    if(V0 == 10) begin
        $display("valor final em A0 (posição no Array): %d", A0);
        $finish;
    end

end


endmodule