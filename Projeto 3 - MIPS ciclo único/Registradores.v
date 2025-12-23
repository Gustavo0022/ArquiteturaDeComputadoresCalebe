module Registradores(
    input wire clk,
    input wire rst,
    input wire [4:0] addrSource, addrTarget, addrDestination,
    input wire regWrite,
    input wire [31:0] writeData,
    output wire [31:0] regSource, regTarget
);


reg [31:0] regs [31:0];

integer i;
always @(posedge rst) begin
    for(i = 0; i < 32; i = i + 1) begin
        regs[i] = 32'b0;
    end
end

assign regSource = regs[addrSource];
assign regTarget = regs[addrTarget];

always @(posedge clk) begin
    if(regWrite && addrDestination != 5'b0)begin 
        regs[addrDestination] <= writeData;
    end
end

endmodule

