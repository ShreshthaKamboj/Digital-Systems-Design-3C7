`timescale 1ns / 1ps
module lfsr_13bit_tb;
    // Parameters
    parameter CLK_PERIOD = 10;  // Clock period in nanoseconds
    parameter RESET_CYCLES = 10;  // Number of clock cycles for reset
    parameter SIM_DURATION = (2**13)-1; // Duration for one full LFSR cycle
    // Inputs
    reg clk;
    reg rst_n;
    reg sh_en;
    // Outputs
    wire [12:0] Q_out;
    wire max_tick_reg;
    wire [12:0] ones_count;
    wire [12:0] zeros_count;
    // Instantiate the Unit Under Test (UUT)
    lfsr_13bit uut (
        .clk(clk),
        .rst_n(rst_n),
        .sh_en(sh_en),
        .Q_out(Q_out),
        .max_tick_reg(max_tick_reg)
    );
    // Instantiate the bit_counter module
    counter counter (
        .clk(clk),
        .rst_n(rst_n),
        .msb_in(Q_out[12]),
        .max_tick(max_tick_reg),
        .ones_count(ones_count),
        .zeros_count(zeros_count)
    );
    // Clock generation
    always begin
        clk = 1'b0;
        #(CLK_PERIOD/2) clk = 1'b1;
        #(CLK_PERIOD/2);
    end
    // Reset and stimulus generation
    initial begin
        // Initialize Inputs
        rst_n = 1'b0;  // Assert reset
        sh_en = 1'b0;

        // Wait for reset
        repeat(RESET_CYCLES) @(posedge clk);
        
        rst_n = 1'b1;  // De-assert reset
        sh_en = 1'b1;  // Enable shifting

        // Run for more than one full LFSR cycle to observe the counter restarting
        repeat(2*SIM_DURATION) @(posedge clk);

        // Finish simulation
        $finish;
    end
    // Generate waveform file
    initial begin
        $dumpfile("lfsr_13bit_tb.vcd");
        $dumpvars(0, lfsr_13bit_tb);
    end
    // Monitoring
    initial begin
        $monitor("Time: %0t, Q_out: %b, max_tick_reg: %b, ones_count: %0d, zeros_count: %0d", 
                 $time, Q_out, max_tick_reg, ones_count, zeros_count);
    end
endmodule