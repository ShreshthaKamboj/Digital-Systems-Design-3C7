`timescale 1ns / 1ps
// Testbench file to run behavioural simulations
module topmodule_testbench;
    reg [5:0] A, B;
    reg [2:0] fxn;
    wire [5:0] led;
    wire bool;
    wire c_out;
    wire overflow;
    // Instantiate the Unit Under Test (UUT)
    topmodule uut(.A(A), .B(B), .fxn(fxn), .led(led), .bool(bool), .c_out(c_out), .overflow(overflow));
    
    initial begin
        // Initialize Inputs
        A = 0;
        B = 0;
        fxn = 0;
        
        // Test pass A
        #10;
        fxn = 3'b000;
        A = 6'b101100;
        B = 6'bx;
        
        // Test pass B
        #10;
        fxn = 3'b001;
        A = 6'bx;
        B = 6'b101100;

        // Test Negate A
        #10;
        fxn = 3'b010;
        A = ~6'b101100;
        B = 6'b000001;

        // Test Negate B
        #10;
        fxn = 3'b011;
        A = 6'b000000;
        B = 6'b010001;
        
        // Test A < B
        #10;
        fxn = 3'b100;
        A = 6'b101100;
        B = 6'b110110;
        
        // Test A XNOR B
        #10;
        fxn = 3'b101;
        A = 6'b101100;
        B = 6'b010101;
        
        // Test addition
        #10;
        fxn = 3'b110;
        A = 6'b101100;
        B = 6'b001000;
        
        // Test subtraction
        #10;
        fxn = 3'b111;
        A = 6'b101100;
        B = 6'b001000;
        
        // Complete the simulation
        #10;
        $finish;
    end
endmodule
