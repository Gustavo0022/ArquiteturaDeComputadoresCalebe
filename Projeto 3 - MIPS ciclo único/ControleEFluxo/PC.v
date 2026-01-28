    module PC(input wire clk,
    input wire rst,
    input wire [31:0] next,
    output wire [31:0] value
    );

    reg [31:0] pc_reg;
    assign value = pc_reg;

    always @(posedge clk) begin
        pc_reg <= (rst)? 32'b0 : next;
    end

    endmodule  