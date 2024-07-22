module lfsr_17bit
    #(parameter seed = 17'b01000001011110001) // Seed parameter for LFSR initialization
    (input clk,          // Clock input signal
     input rst_n,        // Active low asynchronous reset signal
     input sh_en,        // Shift enable signal to control LFSR operation
     output wire Q_out  // MSB of LFSR
//     output wire [16:0] Q_d // Current State of LFSR bit by bit
    );
    reg [16:0] Q_state; // Register holding current state of the LFSR
    wire Q_fb;          // Wire holding feedback bit calculated
    wire [16:0] Q_ns;   // Wire holding next state of the LFSR
    // Sequential logic block to update the state of the LFSR on the rising edge of the clock
    always @(posedge clk or posedge rst_n) begin
        if(rst_n) // If reset is active (low), reset the LFSR state to the seed value
            Q_state <= seed;
        else if (sh_en) // If shift enable is active (high), update the LFSR state to the next state
            Q_state <= Q_ns;
    end
    assign Q_fb = ~(Q_state[16] ^ Q_state[13]); // Calculate feedback using XNOR where taps are at 17 and 14
    assign Q_ns = {Q_state[15:0], Q_fb}; // Form the next state by shifting left and inserting feedback bit
//    assign Q_d = Q_ns; // Output the next state of the LFSR
    assign Q_out = Q_ns[16]; // Output the most significant bit of the LFSR
endmodule