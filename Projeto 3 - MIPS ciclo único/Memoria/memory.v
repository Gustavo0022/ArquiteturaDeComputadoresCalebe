module memory( //memória de dados
    input wire clock, rst,
    input wire [15:0] addr,
    input wire [31:0] writeData, 
    input wire memWrite, memRead,
    output wire [31:0] readData
);


//256 registradores de 32 bits (4 bytes)
reg [31:0] dataMemory [255:0]; 

/*
integer i;
always @(posedge rst) begin
  for(i = 0; i < 256; i = i + 1) begin
        dataMemory[i] = 32'b0;
    end 
end  */ //Não é necessário, pois toda a memória já será carregada com o arquivo datamem.mem

//leitura da memória de dados (seção .data do programa em assembly)
always @(posedge rst) begin
    $readmemh("./programa/datamem.mem", dataMemory, 0, 255);
end

//define o valor da saída baseado no endereço passado para a memória (a depender da flag memRead)
assign readData = memRead ? dataMemory[addr[9:2]] : 32'b0;

//processo de escrita da memória 
always @(posedge clock) begin
    if(memWrite) begin
        dataMemory[addr[9:2]] <= writeData;
    end
end

endmodule