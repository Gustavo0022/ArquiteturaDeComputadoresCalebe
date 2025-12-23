
`timescale 1ns/1ns

module ALU_tb;

reg signed [31:0] a,b;
reg [3:0] alu_ctrl;

wire signed [31:0] res;
wire zero, carry_out, overflow;

ALU DUT(
    a, b, alu_ctrl, res, zero, carry_out, overflow
);

initial begin
    $dumpfile("ALU.vcd");
    $dumpvars(0, ALU_tb);

    $display("---- TESTBENCH UNIDADE LÓGICA E ARITMÉTICA MIPS ----");
    $display("             por Gustavo Gomes Tavares  ");
    $monitor("OP: %b | A:%d | B:%d | Resposta: %d |Overflow: %b| Zero: %b| Resp bin: %b", alu_ctrl, a, b, res, overflow, zero, res);
end

reg signed [32:0] expected;

initial begin
    #10;
    
    $display("Testando AND:");

    a = -32'd20;
    b =  32'd10;
    alu_ctrl = 4'b0000; //AND
    #10;

    a = 32'd7;
    b = 32'd5;
    #10;

    $display("Testando OR:");
    
    a = 32'd10;
    b = 32'd40;
    alu_ctrl = 4'b0001; //OR
    #10;

    a = 32'd9;
    b = 32'd5;
    #10;


    $display("Testando soma:");
    alu_ctrl = 4'b0010; //soma
    #10;

    a = 32'd256;
    b = 32'd256;
    #10;

    a = 32'd32768;
    b = 32'd512;
    #10;

    a = 32'd8902;
    b = 32'd0;
    #10;

    a = 32'd0;
    b = 32'd4750;
    #10;
    
    $display("Testando subtração:");

    alu_ctrl = 4'b0110; //subtração
    #10;

    $display("Testando Set on less than:");

    alu_ctrl = 4'b0111; //slt
    #10;

    $display("Testando XNOR:");
    alu_ctrl = 4'b1100; //xnor
    #10;

    $display("Edge cases (overflow):");
    a = 32'd2147483647;
    b = 32'd1;
    alu_ctrl= 4'd0010;
    #10;

    a = -32'd2147483648;
    b = 32'd1;
    alu_ctrl = 4'b0110; 
    #10;

    $display("Testando 0s:");
    a =32'd2147483647;
    b = -32'd2147483647;
    alu_ctrl= 4'd0010;
    #10;

    a = -50;
    b = -50;
    alu_ctrl = 4'b0110;
    #10;

    a = -32'd10;
    b= 32'd20;
    alu_ctrl = 4'b0111;
    #10;

    a = 32'd10;
    b = 32'd12;
    #10;

    a = 32'd12;
    b = 32'd10;
    #10;

    a = -32'd12;
    b = -32'd14;
    #10;

    $finish;
end

endmodule
    