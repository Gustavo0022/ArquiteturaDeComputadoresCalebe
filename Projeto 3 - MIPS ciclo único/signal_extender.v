module signalExtender(
    input [15:0] wire input,
    output [31:0] wire output
);


assign output = {{16{in[15]}}, input};

endmodule