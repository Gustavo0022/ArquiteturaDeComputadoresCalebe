module full_adder_1bit(
    output wire S,
    output wire Cout,
    input wire A,
    input wire B,
    input wire Cin
);

wire s1;
wire c1;
wire c2;

xor x1(s1, A,B);
xor x2(S,s1,Cin);

and a1(c1,A,B);
and a2(c2,Cin,s1);


or o1(Cout, c1,c2);

endmodule