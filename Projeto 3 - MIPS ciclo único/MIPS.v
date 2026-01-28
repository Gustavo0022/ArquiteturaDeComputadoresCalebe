module MIPS(
    input wire clk,
    input wire rst,
    output wire [31:0] regV0, regA0
);
//fios de controle
wire [31:0] instruction, instrAddress;
wire [1:0] regDst;
wire jump, branch, memRead, memWrite, memToReg,AluSRC, regWrite, bne;
wire [1:0] aluOp;

wire [31:0] next_inst;

//program counter e memória de instrução
PC progCounter(clk, 
            rst,
            next_inst,
            instrAddress);


//Memória de instrução, em que é passado o endereço da instrução de acordo com o PC, e a instrução é retornada
instruction_memory instrMem(clk,rst,instrAddress[9:2],instruction);

//unidade de controle, recebendo o opcode e as flags necessárias para controlar os outros módulos
control centralcontrol(clk, rst,instruction[31:26], 
regDst, //A posição do endereço de saída da instrução (se é RT (tipo I)ou RD (tipo R))
branch, //sinal para o AND que definirá se ocorrerá desvio de fluxo ou não
memRead,memWrite,memToReg, //controladores de leitura e escrita da memória, e se RD recebe um valor da memória ou da ULA
aluOp,AluSRC, //Controlador de operações da ULA, e se o segundo operando é um imediato ou vem de um registrador
regWrite, //controlador de escrita do registrador
jump, //Mux de Jump
bne); //XOR que definirá o beq (valor 0) ou bne (valor 1)


//Registradores e seleção do RD
wire [31:0] regSource, regTarget, regDestination;
wire [4:0] destinationaddr;

//mux que seleciona se o destino vem da seção de RT ou RD da instrução, ou se é um endereço de retorno para o jal e jr (não implementados)
mux_5_x3 regDestSelect(instruction[20:16],
 instruction[15:11], regDst,destinationaddr);

//banco de registradores
registers registerBank(clk,rst,instruction[25:21],instruction[20:16],destinationaddr,regWrite,regDestination,regSource,regTarget, //recebe o campo RS e RT da instrução, e o valor do MUX das linhas acima
 regV0,regA0); //DEBUG: Output dos valores de V0 (argumentos) e A0 (valor a ser impresso). "Simulação de Syscall"

//ALU control e ALU (+ signal extender)
wire [3:0] aluCode;

//controlador da ULA, que recebe a AluOP da unidade de controle e o campo FUNCT da instrução, e passa o código da operação para a ULA
ALUControl aluControl(aluOp,instruction[5:0],aluCode); 

//extensor de sinal do imediato 16->32bits
wire[31:0] extendedImm;
signal_extender signal_extender(instruction[15:0], extendedImm);

//MUX para o sinal da ULA, se o valor vem do imediato ou do RT
wire [31:0] aluSecInput; //output do ALUSrc
mux_32 AluSource(regTarget,extendedImm,AluSRC,aluSecInput);

//fios para saída da ALU
wire[31:0] aluOut;
wire zero, carryOut,overflow;
//ALU (explicada no módulo)
alu_32 ALU(regSource, aluSecInput,aluCode,instruction[10:6],aluOut,zero,carryOut,overflow);


//Memória de dados

wire[31:0] memOut;
//memória, recebendo o valor da ALU (caso seja endereço), o valor a ser escrito,
//as flags de escrita e leitura, e devolvendo a saída da memória para o MUX
memory mem(clk,rst,aluOut[15:0],regTarget,memWrite,memRead,memOut);

//MUX  para a o valor que vai para o registrador de destino (da ULA ou da Memória)
mux_32 memAlu(aluOut,memOut,memToReg,regDestination);


//jump, branch, etc

wire [31:0] jumpAddress;

wire [31:0] branchAdress;
mux_32 jumpBranchSel(branchAdress,jumpAddress,jump,next_inst);

wire [31:0] instrAddressplus4;
wire Cout0;
full_adder_32bit Adderplus4(instrAddress,32'b0100,instrAddressplus4,Cout0);

wire [31:0] shiftedImm;
shift_left_32bit branchShift(extendedImm,shiftedImm);
wire [31:0] branchAdd;

wire Cout1;
full_adder_32bit branchAdder(instrAddressplus4,shiftedImm,branchAdd,Cout1);

wire branchMux;
wire beqBneSelector;

assign beqBneSelector = zero ^ bne;

and A1(branchMux,branch,beqBneSelector);

mux_32 branchSel(instrAddressplus4,branchAdd,branchMux,branchAdress);

wire [27:0] jumpAux;
shift_left_26bit shftlftjmp(instruction[25:0], jumpAux);

jump_solver jump_solver(jumpAux,instrAddressplus4[31:28],jumpAddress);

endmodule



