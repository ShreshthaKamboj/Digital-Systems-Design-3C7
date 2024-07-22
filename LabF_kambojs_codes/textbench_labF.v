`timescale 1ns / 10ps
module textbench_labF();
    reg clk, reset, d; 
    wire q;
    parameter T=20;
    d_ff_reset uut (.clk(clk), .reset(reset), .d(d), .q(q));
    // Giving clock the period 10ns
    always 
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    // Giving reset the period 40ns and 60ns 
    always
    begin
        reset = 1'b1;
        #(2*T);
        reset = 1'b0;
        #(3*T);
        reset = 1'b1;
        #(2*T);
        reset = 1'b0;
        #(3*T);
    end 
    // Giving d input the period 10ns, 60ns, 40ns, 100ns, and 40ns
    initial
    begin
        d = 1'b0;
        #T;
        d = 1'b1;
        #(3*T);
        d = 1'b0;
        #(2*T);
        d = 1'b1;
        #(5*T);
        d = 1'b0;
        #(2*T);
    end
    
endmodule
