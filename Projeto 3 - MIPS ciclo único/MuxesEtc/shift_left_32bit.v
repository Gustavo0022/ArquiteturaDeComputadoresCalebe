module shift_left_32bit(
    input wire [31:0] in,
    output wire [31:0] out  
);

assign out = in << 2;
endmodule