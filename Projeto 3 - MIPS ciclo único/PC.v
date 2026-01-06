    module PC(input wire clk,
    input wire rst,
    input wire [31:0] next,
    output wire [31:0] value
    );

    assign value = PC;

    always @(posedge clk) begin
        PC <= (rst)? 32'b0 : next;
    end

    endmodule  