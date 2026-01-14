module top(

    input wire clk,
    input wire rst
);
//fios de controle
wire [31:0] instruction, instrAdress;
wire regDst, jump, branch, memRead, memWrite, memToReg,AluSRC, regWrite;
wire [1:0] aluOp;

wire [31:0] next_inst;

//program counter e memória de instrução
PC progCounter(clk, 
            rst,
            next_inst,
            instrAdress);

instruction_memory instrMem(instrAdress[9:2],instruction);

//unidade de controle
control centralcontrol(clk, rst,instruction[31:26], regDst,branch,memRead,
memWrite,memToReg,aluOp,
AluSRC,regWrite,jump);


//Registradores e seleção do RD
wire [31:0] regSource, regTarget, regDestination;
wire [4:0] destinationaddr;
mux_5 regDestSelect(instruction[20:16],
 instruction[15:11], regDst,destinationaddr);

Registers registerBank(clk,rst,instruction[25:21],instruction[20:16],destinationaddr,regWrite,regDestination,regSource,regTarget);

//ALU control e ALU (+ signal extender)
wire [3:0] aluCode;
ALUControl aluControl(aluOp,instruction[5:0],aluCode);

wire[31:0] extendedImm;
signal_extender signal_extender(instruction[15:0], extendedImm);

wire [31:0] aluSecInput; //output do ALUSrc
mux_32 AluSource(regTarget,extendedImm,AluSRC,aluSecInput);

wire[31:0] aluOut;
wire zero, carryOut,overflow;

alu_32 ALU(regSource, aluSecInput,aluCode,aluOut,zero,carryOut,overflow);


//Memória

wire[31:0] memOut;
memory mem(clk,rst,aluOut[15:0],regTarget,memWrite,memRead,memOut);

mux_32 memAlu(aluOut,memOut,memToReg,regDestination);


//jump, branch, etc

wire [31:0] jumpAddress;

wire [31:0] branchAdress;
mux_32 jumpBranchSel(branchAdress,jumpAddress,jump,next_inst);

wire [31:0] instrAdressplus4;
wire Cout0;
full_adder_32bit Adderplus4(instrAdress,32'b0100,instrAdressplus4,Cout0);

wire [31:0] shiftedImm;
shift_left2_32bit branchShift(extendedImm,shiftedImm);
wire [31:0] branchAdd;

wire Cout1;
full_adder_32bit branchAdder(instrAdressplus4,shiftedImm,branchAdd,Cout1);

wire branchMux;

and A1(branchMux,branch,zero);

mux_32 branchSel(instrAdressplus4,branchAdd,branchMux,branchAdress);

wire [27:0] jumpAux;
shiftleft2_26bit shftlftjmp(instruction[25:0], jumpAux);

jump_solver jump_solver(jumpAux,instrAdressplus4[31:28],jumpAddress);


endmodule



