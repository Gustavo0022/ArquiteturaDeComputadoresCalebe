module jump_solver(
    input wire [27:0] instr,
    input wire [3:0] pc4,
    output wire [31:0] out
);

//módulo para concatenar os valores do PC com a instrução a ser pulada. 
//O valor de instr vem do deslocador à esquerda de 26 bit, 
//que inclui o conteúdo da instrução deslocado à esquerda. 
//PC4 representa os 4 bits mais significativos do próximo endereço do PC.

assign out = {pc4,instr};
endmodule