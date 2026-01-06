module control(
    input rst,
	input clk,
    input wire [5:0] opcode,
    output wire regDst,
    output wire branch,
    output wire memRead, memWrite,
    output wire memToReg,
    output wire [1:0] aluOp,
    output wire aluSrc,
    output wire regWrite,
    output wire PCSrc,
    output wire jmp;
);



always @(*) begin
    case(opcode)
        8'b0: begin //R-type
            regDst <= 1'b1;
            memRead <= 1'b0;
            memWrite <= 1'b0;
            aluSrc <= 1'b0;
            memToReg <= 1'b0;
            PCSrc <= 1'b0;
            aluOp <= 2'b10;
            branch <=  1'b0;
            jmp <= 1'b0;
            regWrite <= 1'b1;
        end
        8'b100011: begin //lw
            regDst <= 1'b0;
            memRead <= 1'b1;
            memWrite <= 1'b0;
            aluSrc <= 1'b1;
            memToReg <= 1'b1;
            PCSrc <= 1'b0;
            aluOp <= 2'b00;
            branch <= 1'b0;
            jmp <= 1'b0;
            regWrite <= 1'b1;
        end
        8'b101011: begin //sw
            regDst <= 1'b0; //dont care
            memRead <= 1'b0;
            memWrite <= 1'b1;
            aluSrc <= 1'b1;
            memToReg <= 1'b0; //don't care
            PCSrc <= 1'b0;
            aluOp <= 2'b00;
            branch <= 1'b0;
            jmp <= 1'b0;
        end
        8'b000100: begin //beq
            regDst <= 1'b0; //dont care
            memRead <= 1'b0;
            memWrite <= 1'b0;
            aluSrc <= 1'b0;
            memToReg <= 1'b0; //don't care
            PCSrc <= 1'b0;
            aluOp <= 2'b01;
            branch <= 1'b1;
            jmp <= 1'b0;
        end
        8'b000010: begin //jmp
            regDst <= 1'b0;
            memRead <= 1'b0;
            memWrite <= 1'b0;
            aluSrc <= 1'b0;
            memToReg <= 1'b0;
            PCSrc <= 1'b0;
            aluOp <= 2'b01;
            branch <= 1'b1;
            jmp <= 1'b1;
        end
        8'b000011: begin //jal
            regDst <= 2'b10;
            memRead <= 1'b0;
            memWrite <= 1'b0;
            aluSrc <= 1'b0;
            memToReg <= 1'b0; //implementar o trit
            PCSrc <= 1'b0;
            aluOp <= 2'b01;
            branch <= 1'b1;
            jmp <= 1'b1;
        end


    endcase
end

endmodule

