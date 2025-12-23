module somador8bit(
    output [7:0] Sum,
    output Cout,
    input [7:0] A,
    input [7:0] B,
    input Cin

);

wire [6:0] cout;

somador1bit s0(.S(Sum[0]), .Cout(cout[0]), .A(A[0]), .B(B[0]), .Cin(Cin) );
somador1bit s1(.S(Sum[1]), .Cout(cout[1]), .A(A[1]), .B(B[1]), .Cin(cout[0]));
somador1bit s2(.S(Sum[2]), .Cout(cout[2]), .A(A[2]), .B(B[2]), .Cin(cout[1]));
somador1bit s3(.S(Sum[3]), .Cout(cout[3]), .A(A[3]), .B(B[3]), .Cin(cout[2]));
somador1bit s4(.S(Sum[4]), .Cout(cout[4]), .A(A[4]), .B(B[4]), .Cin(cout[3]));
somador1bit s5(.S(Sum[5]), .Cout(cout[5]), .A(A[5]), .B(B[5]), .Cin(cout[4]));
somador1bit s6(.S(Sum[6]), .Cout(cout[6]), .A(A[6]), .B(B[6]), .Cin(cout[5]));
somador1bit s7(.S(Sum[7]), .Cout(Cout), .A(A[7]), .B(B[7]), .Cin(cout[6]));


endmodule