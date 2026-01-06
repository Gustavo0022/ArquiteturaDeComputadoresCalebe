module top(
    input wire clk,
    input wire rst
);
//fios de controle
wire [31:0] instruction;
wire regDst, jump, branch, memRead, memWrite, memToReg,AluSRC, regWrite;
wire [1:0] aluOp;

PC progCounter(clk, rst, ,instruction);

//unidade de controle
control centralcontrol(clk, rst,instruction[31:26], regDst,branch,memRead,memWrite,memToReg,aluOp,AluSRC,regWrite,jump);


//Registradores e seleção do RD
wire [32:0] regSource, regTarget, regDestination;
wire [4:0] destinationaddr;
mux_5 regDestSelect(instruction[20:16], instruction[15:11], regDst,destinationaddr);

Registers registerBank(clk,rst,instruction[25:21],instruction[20:16],destinationaddr,regWrite,regSource, regTarget);

//ALU control e ALU (+ signal extender)
wire [3:0] aluCode;
ALUControl aluControl(aluOp,instruction[5:0],aluCode);

wire[31:0] extendedImm;
signal_extender(instruction[15:0], extendedImm);

wire [31:0] aluSecInput; //output do ALUSrc
mux_32 AluSource(regTarget,extendedImm,AluSRC,aluSecInput);

wire[31:0] aluOut;
wire zero, carryOut,overflow;

alu_32 ALU(regSource, aluSecInput,aluCode,aluOut,zero,carryOut,overflow);


//Memória

wire[31:0] memOut;
memory mem(clk,rst,aluOut[15:0],regTarget,memOut);

mux_32(aluOut,memOut,memToReg,regDestination);

//fazer instruction memory, interface com o PC, parte de Branch e JMP




