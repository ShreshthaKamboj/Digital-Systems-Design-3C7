`timescale 1ns / 1ps
module top_module(
    input clk_in,  // Original fast clock (e.g., 50MHz)
    input rst_n,   // Asynchronous reset, active low
    input sh_en,   // Shift enable for LFSR
    output [12:0] Q_out,  // LFSR output
    output max_tick_reg  // Indicates a full LFSR cycle
);
// Instantiate the clock divider
wire slow_clk; // This will be the 1Hz clock
clock_divider clk_div(
    .clk_in(clk_in),
    .rst_n(rst_n),
    .clk_out(slow_clk)
);
// Instantiate the LFSR
lfsr_13bit lfsr(
    .clk(slow_clk),  // Use the 1Hz clock from the clock divider
    .rst_n(rst_n),
    .sh_en(sh_en),
    .Q_out(Q_out),
    .max_tick_reg(max_tick_reg)
);
endmodule