module somador32bit(
    input [31:0] A,
    input [31:0] B,
    output [31:0] Sum,
    output Cout
);

wire [2:0] cout;


somador8bit s0(Sum[7:0], cout[0], A[7:0], B[7:0], 1'b0 );
somador8bit s1(Sum[15:8], cout[1], A[15:8], B[15:8], cout[0]);
somador8bit s2(Sum[23:16], cout[2], A[23:16], B[23:16], cout[1]);
somador8bit s3(Sum[31:24], Cout,A[31:24], B[31:24], cout[2]);

endmodule

