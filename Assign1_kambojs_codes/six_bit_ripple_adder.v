`timescale 1ns / 1ps
//Module for 6 bit ripple adder/subtractor
module six_bit_ripple_adder(
    input [5:0] x, y,   //Inputs to the full adders
    input sel,      // Select for adder/subtractor
    output overflow, c_out,     //Overflow and carry out 
    output [5:0] sum        //sum of each full adders
);
    wire carry1, carry2, carry3, carry4, carry5, carry6;
    wire [5:0] b_input;
    // Generate 2's complement if sel is high
    assign b_input = y ^ {6{sel}};        //XOR of input and sel
    // Instantiate 6 full adders
    FullAdder fa_0 (.a(x[0]), .b(b_input[0]), .cin(sel), .s(sum[0]), .cout(carry1));
    FullAdder fa_1 (.a(x[1]), .b(b_input[1]), .cin(carry1), .s(sum[1]), .cout(carry2));
    FullAdder fa_2 (.a(x[2]), .b(b_input[2]), .cin(carry2), .s(sum[2]), .cout(carry3));
    FullAdder fa_3 (.a(x[3]), .b(b_input[3]), .cin(carry3), .s(sum[3]), .cout(carry4));
    FullAdder fa_4 (.a(x[4]), .b(b_input[4]), .cin(carry4), .s(sum[4]), .cout(carry5));
    FullAdder fa_5 (.a(x[5]), .b(b_input[5]), .cin(carry5), .s(sum[5]), .cout(carry6));
    // Detect overflow and carry out 
    assign overflow = carry5 ^ carry6;
    assign c_out = carry6;
endmodule
