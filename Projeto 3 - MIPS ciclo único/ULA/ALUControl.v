module ALUControl(
    input wire [1:0] ALUOp,
    input wire [5:0] functField,
    output reg  [3:0] Operation
);

always @(*) begin
    case(ALUOp) 
        2'b00 : Operation = 4'b0010; 
        2'b01 : Operation = 4'b0110;
        2'b10: begin
            case(functField[5:0])
                6'b100000: Operation = 4'b0010; //add
                6'b100010: Operation = 4'b0110; //subtract
                6'b100100: Operation = 4'b0000; //AND
                6'b100101: Operation = 4'b0001; //OR
                6'b101010: Operation = 4'b0111; //SLT
                6'b000000: Operation = 4'b1000; //sll
                6'b000010: Operation = 4'b1001; //srl
                default: Operation = 4'b0;
            endcase
        end
        2'b11: begin //DONT CARE do MSB
            case(functField[3:0])
                4'b0010: Operation = 4'b0110;  //subtract
                4'b1010: Operation = 4'b0111; //SLT
                4'b0111: Operation = 4'b1100; //NOR
                default: Operation = 4'b0000;
            endcase
        end
        default: Operation = 4'b0;
    endcase
end
endmodule

