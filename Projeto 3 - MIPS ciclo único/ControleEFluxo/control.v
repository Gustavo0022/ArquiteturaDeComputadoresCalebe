module control(
    input clk,
	input rst,
    input wire [5:0] opcode,
    output reg [1:0] regDst,
    output reg branch,
    output reg memRead, memWrite,
    output reg memToReg,
    output reg [1:0] aluOp,
    output reg aluSrc,
    output reg regWrite,
    output reg jmp,
    output reg bne
);



always @(*) begin
    //flags definidas inicialmente para 0, com 
    regDst = 2'b00;
    branch = 1'b0;
    memRead = 1'b0;
    memWrite = 1'b0;
    memToReg = 1'b0;
    aluOp = 2'b00;
    aluSrc = 1'b0;
    regWrite = 1'b0;
    jmp = 1'b0;
    bne = 1'b0;

    case(opcode)
        6'b0: begin //R-type
            regDst = 2'b01;
            aluOp = 2'b10;
            regWrite = 1'b1;
        end
        6'b100011: begin //lw
            memRead = 1'b1;
            aluSrc = 1'b1;
            memToReg = 1'b1;
            regWrite = 1'b1;
        end
        6'b101011: begin //sw
            memWrite = 1'b1;
            aluSrc = 1'b1;
        end
        6'b000100: begin //beq
            aluOp = 2'b01;
            branch = 1'b1;
            regWrite = 1'b0;
        end
        6'b000101: begin //bne
            aluOp = 2'b01;
            branch = 1'b1;
            regWrite = 1'b0;
            bne = 1'b1;
        end
        6'b000010: begin //jump
            aluOp = 2'b01;
            branch = 1'b1;
            jmp = 1'b1;
        end
        6'b001000: begin // addi
            aluSrc   = 1'b1;  // O segundo operando da ALU é o Imediato (não o reg 'rt')
            regWrite = 1'b1;
        end

    endcase
end

endmodule

