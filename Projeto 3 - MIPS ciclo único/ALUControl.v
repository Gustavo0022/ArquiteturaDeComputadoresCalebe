module ALUControl(
    wire input [1:0] ALUOp;
    wire input [5:0] functField;
    wire output [3:0] Operation;
);

always @(*) begin
    case(ALUOp) 
        2'b00 : Operation = 4'b0010;
        2'b01 : Operation = 4'b0110;
        2'b10: begin
            case(functField[3:0])
                4'b0000: Operation = 4'b0010;
                4'b0010: Operation = 4'b0110;
                4'b0100: Operation = 4'b0000;
                4'b0101: Operation = 4'b0001;
                4'b1010: Operation = 4'b0111;
                default: Operation = 4'b0;
            endcase
        end
        2'b11: begin
            case(functField[3:0])
                4'b0010: Operation = 4'b0110;
                4'b1010: Operation = 4'b0111;
                default = Operation = 4'b0;
            endcase
        end
        default: Operation = 4'b0;
    endcase
end
endmodule

