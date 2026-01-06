module mux_32(
    input wire [31:0] A, B,
    input wire select,
    output wire [31:0] out;
);

assign out = (select == 1'b1) ? B : A;

endmodule