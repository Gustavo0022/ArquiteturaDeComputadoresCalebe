module jump_solver(
    input wire [27:0] instr,
    input wire [3:0] pc4,
    output wire [31:0] out
);

assign out = {pc4,instr};
endmodule