
`timescale 1ns/1ns

module tb_alu_32;

reg signed [31:0] a,b;
reg [3:0] alu_ctrl;

wire signed [31:0] res;
wire zero, carry_out, overflow;
reg signed [32:0] expected;

reg [31:0] seed; 

integer  tests = 0;
integer  passed = 0;

alu_32 DUT(
    a, b, alu_ctrl, res, zero, carry_out, overflow
);


initial begin
    $dumpfile("ALU.vcd");
    $dumpvars(0, tb_alu_32);

    $display("---- MIPS ARITHMETIC LOGIC UNIT TESTBENCH ----");
    $display("              by Gustavo Gomes  ");
    
    //uncomment the line below to print the full log
    /*$monitor("OP: %b | A:%d | B:%d | Ans: %d |Overflow: %b| Zero: %b| Bin: %b", alu_ctrl, a, b, res, overflow, zero, res); */
end


task check;
    input [31:0] expected;
    begin
        
        #2;
        tests = tests + 1;
        if(res != expected) begin
             $display("Error:\nOp:%b |A:%d(%b) |B:%d (%b)\nExpected: %d (%b) | Actual: %d (%b)\n Zero: %b ", alu_ctrl, a, a, b, b, expected, expected, res, res, zero);
        end else begin
            passed = passed +1;
        end
    end
endtask



initial begin
    #10;
    
    //AND TESTS (with random numbers to see how it goes)
    $display("Testing AND");

    a = $random(seed);
    b = $random(seed);
    alu_ctrl = 4'b0000; //AND
    expected = a&b;
    #10;

    check(expected);

    a = $random(seed);
    b = $random(seed);
    expected = a&b;
    #10;
    check(expected);

    //OR Tests (again, with random numbers)
    $display("Testing OR");
    
    a = $random(seed);
    b = $random(seed);
    alu_ctrl = 4'b0001; //OR
    expected = a | b;
    #10;

    check(expected);

    a = $random(seed);
    b = $random(seed);
    expected = a | b;
    #10;

    check(expected);

    //Sum tests
    $display("Testing sum");
    alu_ctrl = 4'b0010;
    expected = a+b; //soma
    #10;

    check(expected);

    //Testing the first 8 bit full adder carry-out to the next one
    a = 32'd256;
    b = 32'd256;
    expected = a + b;
    #10;

    check(expected);

    //testing the second 8 bit full adder carry-out
    a = 32'd32768;
    b = 32'd512;
    expected = a + b;
    #10;

    check(expected);

    //adding a number with zero
    a = 32'd8902;
    b = 32'd0;
    expected = a + b;
    #10;

    check(expected);

    //adding other number with zero (on a different input)
    a = 32'd0;
    b = 32'd4750;
    expected = a + b;
    #10;

    check(expected);

    
    //Subtraction tests
    $display("Testing subtraction");

    //subtracting a number from zero
    alu_ctrl = 4'b0110; //subtração
    expected = a-b;
    #10;

    check(expected);

    //subtracting zero from a number
    a = 32'd8902;
    b = 32'd0;
    expected = a - b;
    #10;

    check(expected);

    //0 - 0
    a = 32'b0;
    b = 32'b0;
    expected = a-b;
    #10;

    check(expected);

    //slt test
    $display("Testing Set on less than");

    //random values
    a = $random(seed);
    b = $random(seed);
    alu_ctrl = 4'b0111; //slt
    expected = a < b;
    #10;

    check(expected);

    a = $random(seed);
    b = $random(seed);
    expected = a<b;
    #10;

    check(expected);


    //negative values
    a = -32'd14;
    b = -32'd12;
    expected = a<b;
    #10;

    check(expected);

    //NOR tests
    $display("Testando NOR");

    //random values
    a = $random(seed);
    b = $random(seed);
    alu_ctrl = 4'b1100; //nor
    expected = ~(a | b);
    #10;

    check(expected);

    //Edge Case Test
    $display("Edge cases (overflow):");

    //Sum Overflow
    a = 32'd2147483647;
    b = 32'd1;
    expected = a + b;
    alu_ctrl= 4'd0010;
    #10;

    tests = tests +1;
    #1;

    if(overflow != 1) begin
        $display("Error:\nOp:%b |A:%d(%b) |B:%d (%b)\nExpected: %d (%b) | Actual: %d (%b)\n Overflow: %b", alu_ctrl, a, a, b, b, expected, expected, res, res, overflow);
    end else begin
        passed = passed +1;
    end
    

    a = -32'd2147483648;
    b = 32'd1;
    expected = a - b;
    alu_ctrl = 4'b0110; 
    #10;

    tests = tests +1;
    #1;

    if(overflow != 1) begin
        $display("Error:\nOp:%b |A:%d(%b) |B:%d (%b)\nExpected: %d (%b) | Actual: %d (%b)\n Overflow: %b", alu_ctrl, a, a, b, b, expected, expected, res, res, overflow);
    end else begin
        passed = passed +1;
    end

    //Zeroes test
    $display("Testing 0s");

    //Biggest value - smallest value
    a =32'd2147483647;
    b = -32'd2147483647;
    alu_ctrl= 4'd0010;
    expected = a + b;
    #10;

    tests = tests +1;
    #1;

    if(res != expected || zero != 1'b1) begin
        $display("Error:\nOp:%b |A:%d(%b) |B:%d (%b)\nExpected: %d (%b) | Actual: %d (%b)\n Zero: %b", alu_ctrl, a, a, b, b, expected, expected, res, res, zero);
    end else begin
        passed = passed +1;
    end

    //cancelling values in subtraction (-50) - (-50) = -50 + 50 
    a = -50;
    b = -50;
    alu_ctrl = 4'b0110;
    expected = a - b;
    #10;

    tests = tests +1;
    #1;

    if(res != expected || zero != 1'b1) begin
        $display("Error:\nOp:%b |A:%d(%b) |B:%d (%b)\nExpected: %d (%b) | Actual: %d (%b)\n Zero: %b", alu_ctrl, a, a, b, b, expected, expected, res, res, zero);
    end else begin
        passed = passed +1;
    end

    a = 32'd12;
    b = 32'd10;
    expected = a<b;
    alu_ctrl = 4'b0111;
    #10;

    tests = tests +1;
    #1;

    if(res != expected || zero != 1'b1) begin
        $display("Error:\nOp:%b |A:%d(%b) |B:%d (%b)\nExpected: %d (%b) | Actual: %d (%b)\n Zero: %b", alu_ctrl, a, a, b, b, expected, expected, res, res, zero);
    end else begin
        passed = passed +1;
    end

    $display("%d/ %d tests passed", passed, tests);
    if (tests == passed) begin
        $display("All tests passed");
    end else begin
        $display("Errors detected. Please verify the design and try again");
    end

end

endmodule
    