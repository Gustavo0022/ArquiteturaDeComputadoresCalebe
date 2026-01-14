module instruction_memory(
    input wire [7:0] addr,
    output wire [31:0] instr
);

reg [31:0] instructions [255:0];

integer i;

initial begin
    for(i = 0; i<256; i++)begin
        instructions[i] = 32'b0;
    end
    
    $readmemb("./algoritmo/algo.mem", instructions,0,255);
end
assign instr = instructions[addr];
endmodule