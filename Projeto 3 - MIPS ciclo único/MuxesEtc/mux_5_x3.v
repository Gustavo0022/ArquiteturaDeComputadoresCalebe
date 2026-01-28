module mux_5_x3(
    input wire [4:0] A, B,
    input wire [1:0] select,
    output wire [4:0] out
);

assign out = (select == 1'b1) ? B :
(select == 2'b10) ? 32'd31 : A;



endmodule