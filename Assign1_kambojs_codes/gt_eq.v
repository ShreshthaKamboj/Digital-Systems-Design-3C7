`timescale 1ns / 1ps
module gt_eq(input wire [7:0] a, b, output wire answer, equal, greater);
wire [3:0] gt_results;  // Results of greater than comparisons
wire [3:0] eq_results;  // Results of equality comparisons
// Instantiate the eq2 module for equality comparison
eq2 bit_01 (.a(a[1:0]), .b(b[1:0]), .aeqb(eq_results[0]));  // Compare the two least significant bits
eq2 bit_23 (.a(a[3:2]), .b(b[3:2]), .aeqb(eq_results[1]));
eq2 bit_45 (.a(a[5:4]), .b(b[5:4]), .aeqb(eq_results[2]));
eq2 bit_67 (.a(a[7:6]), .b(b[7:6]), .aeqb(eq_results[3]));  // Compare the two most significant bits
// Instantiate the gt module for greater than comparisons
gt Bit_01 (.a(a[1:0]), .b(b[1:0]), .ans(gt_results[0]));    // Compare the two least significant bits
gt Bit_23 (.a(a[3:2]), .b(b[3:2]), .ans(gt_results[1]));
gt Bit_45 (.a(a[5:4]), .b(b[5:4]), .ans(gt_results[2]));
gt Bit_67 (.a(a[7:6]), .b(b[7:6]), .ans(gt_results[3]));    // Compare the two most significant bits
// Determine if the first number is greater than the second number by evaluating a series of conditions
// It checks if any bit in the first number is greater than the corresponding bit in the second number,
// taking into account the equality of higher-order bits
assign greater = gt_results[3] | (eq_results[3] & gt_results[2]) | (eq_results[3] & eq_results[2] & gt_results[1]) | (eq_results[3] & eq_results[2] & eq_results[1] & gt_results[0]);
// Determine if the two numbers are equal by checking if all corresponding bits are equal.
assign equal = eq_results[0] & eq_results[1] & eq_results[2] & eq_results[3];
// Combine the 'greater' and 'equal' signals to produce the final 'answer'
assign answer = greater | equal;
endmodule
