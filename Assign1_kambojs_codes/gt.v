`timescale 1ns / 1ps
//Module for greater than logical operation for a 2 bit number
module gt(input wire [1:0] a, b, output wire ans);
    // Internal wires p1, p2, and p3 declared to hold intermediate results
    wire p1,p2,p3;
    assign p1 = a[1] & ~b[1];     // p1 is true if the MSB of 'a' is 1 and the MSB of 'b' is 0
    assign p2 = a[1] == b[1];     // p2 is true if the MSB's of 'a' and 'b' are equal
    assign p3 = a[0] & ~b[0];     // p3 is true if the LSB of 'a' is 1 and the LSB of 'b' is 0
    // a is greater than b if:
    // -> The MSB of a is greater than the MSB of b, or
    // -> The MSBs are equal, but the LSB of a is greater than the LSB of b.
    assign ans = p1 | (p2 & p3);
endmodule
