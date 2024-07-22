`timescale 1ns / 1ps
module lfsr_13bit
    #(parameter seed = 13'h1EE) // Adjusted seed parameter width to match LFSR size
    ( input clk, input rst_n, input sh_en, output reg [12:0] Q_out, output reg max_tick_reg);
    reg [12:0] Q_state;
    wire Q_fb;
    wire [12:0] Q_ns;
    localparam [12:0] max_value = 13'h1FFF; // Maximum value for a 13-bit LFSR
    // Asynchronous active-low reset
    always @ (posedge clk or negedge rst_n) begin // Changed to negedge rst_n
        if (!rst_n) // Active-low reset condition
            Q_state <= seed; // Reset state to seed value
        else if (sh_en)
            Q_state <= Q_ns; // Shift operation
    end
    // Next state logic with feedback function using XNOR
    assign Q_fb = ~(Q_state[13] ^ Q_state[4] ^ Q_state[3] ^ Q_state[1]); // Changed to XNOR
    assign Q_ns = {Q_state[11:0], Q_fb}; // Shift left and insert feedback  
    // Output logic
    always @ (posedge clk) begin // Explicitly specify posedge clk
        Q_out <= Q_state; // Update output
        // Check if LFSR reached its maximum value and reset max_tick_reg
        if(Q_state == max_value) begin
            max_tick_reg <= 1'b1; // Set max_tick_reg high when full count is reached
        end else begin
            max_tick_reg <= 1'b0; // Reset max_tick_reg
        end
    end
endmodule