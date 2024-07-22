`timescale 1ns / 1ps
//Module for performing XNOR on two 6 bit inputs
module AxnorB(input [5:0] a,b, output [5:0] value);
    //Performing bitwise xnor operation and storing result bitwise in value
    assign value[0] = ~(a[0] ^ b[0]);
    assign value[1] = ~(a[1] ^ b[1]);
    assign value[2] = ~(a[2] ^ b[2]);
    assign value[3] = ~(a[3] ^ b[3]);
    assign value[4] = ~(a[4] ^ b[4]);
    assign value[5] = ~(a[5] ^ b[5]);
endmodule