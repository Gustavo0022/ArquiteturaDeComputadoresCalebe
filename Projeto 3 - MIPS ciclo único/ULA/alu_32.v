module alu_32(
    input wire [31:0] a,
    input wire[31:0] b,
    input wire [3:0] alu_ctrl,
    input wire [4:0] shamt,
    output reg [31:0] result,
    output wire zero,
    output reg carry_out,
    output wire overflow
    );

//MESMA ALU DO PROJETO 1


//Armazena o resultado do somador
wire[31:0] resultadoSomaSubtracao;

// TRATAMENTO DO SOMADOR-SUBTRATOR 
//O somador também pode servir como subtrator
//da seguinte forma:
// Soma: x = a + b
// Subtração: x = a - b = a + (-b) = a + (~b+1) 
//      representação por complemento de 2 ^^^
// -------------------------------------------

wire carry_out_pre; //carry-out sem tratamento
//FUNCIONAMENTO DO CARRY-OUT:
//soma: carry-out = carry-out-pre
//subtração: carry-out = ~carry-out-pre
// -------------------------------------------

//Tratamento de b para soma ou subtração/slt
wire[31:0] b_temp;
assign b_temp = (alu_ctrl == 4'b0110 || alu_ctrl == 4'b0111)? (~b+1'b1) : b;

// -------------------------------------------

//instância do somador (/subtrator)
full_adder_32bit adder(a,b_temp,resultadoSomaSubtracao,carry_out_pre);

//atribuição do zero 
assign zero = (result == 32'd0) ? 1'b1 : 1'b0;

//ATRIBUIÇÃO DO OVERFLOW:
//se a soma de dois números de mesmo sinal resultar
//em um valor de sinal diferente, houve overflow
assign overflow = (a[31] == b_temp[31] && resultadoSomaSubtracao[31] != a[31]) ?  1'b1 : 1'b0;

// -------------------------------------------

//LÓGICA DE ESCOLHA
always @(*) begin
    //inicialização dos valores de saída
    result = 32'd0;
    carry_out = 1'b0;
    case(alu_ctrl)
        4'b0000: result = a & b;    //AND bit a bit  
        4'b0001: result = a | b;    //OR bit a bit
        4'b0010: begin              //Soma
            //atribuição do resultado do somador e do carry_out tratado
            result = resultadoSomaSubtracao; 
            carry_out = carry_out_pre;
        end
        4'b0110: begin              //Subtração
            //atribuição do resultado do subtrator e do carry_out tratado
            result = resultadoSomaSubtracao;
            carry_out = ~carry_out_pre;
        end

        //SLT (Set on Less than) trata com um XOR resultado da subtração
        //junto ao overflow, pois a inversão do bit de sinal do overflow 
        //pode gerar um resultado falso para números enormes
        4'b0111: result = {31'b0, resultadoSomaSubtracao[31] ^ overflow};
        4'b1000: result = b << shamt;
        4'b1001: result = b >> shamt;
        4'b1100: result = ~(a ^ b); //XNOR
        default: result = 32'd0;
    endcase
end

endmodule