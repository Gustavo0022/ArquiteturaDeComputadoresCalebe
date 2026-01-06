module memory(
    input wire clock, rst
    input wire [15:0] addr,
    input wire [31:0] writeData, readData,
    input wire memWrite, memRead,
);

reg [31:0] mem [255:0];


always @(posedge rst) begin
    for(i = 0; i < 256; i = i + 1) begin
        regs[i] = 32'b0;
    end
end

assign readData = memRead ? mem[addr[9:2]] : 32'b0;

always @(posedge clock) begin
    if(memWrite) begin
        mem[addr[9:2]] = writeData;
    end
end

endmodule