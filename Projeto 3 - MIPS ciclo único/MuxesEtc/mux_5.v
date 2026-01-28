module mux_5(
    input wire [4:0] A, B,
    input wire select,
    output wire [4:0] out
);

assign out = (select == 1'b1) ? B : A;

endmodule