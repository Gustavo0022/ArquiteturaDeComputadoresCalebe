module instruction_memory(
    input wire clk, rst,
    input wire [7:0] addr,
    output wire [31:0] instr
);

reg [31:0] instructions [255:0];

integer i;

//sempre que for resetado, carrega o "instrmem.mem" novamente
always @(posedge rst) begin
    /* for(i = 0; i<256; i++)begin
        instructions[i] <= 32'b0;
    end */
    $readmemh("./programa/instrmem.mem", instructions,0,255);
end

//determina o valor da instrução a ser utilizada de acordo com o endereço do PC
assign instr = instructions[addr];
endmodule