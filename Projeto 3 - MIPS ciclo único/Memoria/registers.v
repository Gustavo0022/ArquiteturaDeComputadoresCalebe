module registers(
    input wire clk,
    input wire rst,
    input wire [4:0] addrSource, addrTarget, addrDestination,
    input wire regWrite,
    input wire [31:0] writeData,
    output wire [31:0] regSource, regTarget,
    output reg [31:0] registerv0, registera0
);

//32 registradores de 32 bit
reg [31:0] regs [31:0];

//reset do valor dos registradores
integer i;
always @(posedge rst) begin
    for(i = 0; i < 32; i = i + 1) begin
        regs[i] <= 32'b0;
    end
end

//valores de RS e RT
assign regSource = regs[addrSource];
assign regTarget = regs[addrTarget];

//processo de escrita dos registradores
always @(posedge clk) begin
    if(regWrite && addrDestination != 5'b0)begin 
        regs[addrDestination] <= writeData;
    end

    //DEBUG E VISUALIZAÇÃO: Visualização dos valores de V0 e A0 para saída no testbench
    registerv0 = regs[2];
    registera0 = regs[4];
    
end
 

endmodule

