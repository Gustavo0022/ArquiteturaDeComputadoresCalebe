module mux_32_x3(
    input wire [31:0] A, B,
    input wire [2:0] select,
    output wire [31:0] out;
);

assign out = (select == 1'b1) ? B :
(select == 2'b10) ? 32'd31 : A;



endmodule