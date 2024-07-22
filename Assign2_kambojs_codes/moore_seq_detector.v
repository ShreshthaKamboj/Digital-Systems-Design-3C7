module moore_seq_detector(
    input clk, // Clock input signal
    input rst_n, // Active low asynchronous reset signal
    input check, // Input signal to start checking the pattern
    output reg pattern_detected); // Output signal indicating when the pattern is detected
// State declaration with 4-bit encoding for a 12-bit sequence detection
localparam [3:0] A = 4'b0001, // Initial state
                 B = 4'b0010, // State for each bit in the sequence
                 C = 4'b0011,
                 D = 4'b0100,
                 E = 4'b0101,
                 F = 4'b0110,
                 G = 4'b0111,
                 H = 4'b1000,
                 I = 4'b1001,
                 J = 4'b1010,
                 K = 4'b1011,
                 L = 4'b1100,
                 M = 4'b1101; // Final state indicating the end of the sequence
reg [3:0] current_state, next_state; // Registers holding current and next state
// State transition logic, updates the current state on the rising edge of the clock
always @(posedge clk or posedge rst_n) begin
    if (rst_n) // If reset is active (low), reset to initial state A
        current_state <= A;
    else
        current_state <= next_state; // Otherwise, transition to the next state
end
// Next state logic based on the current state and input bit
always @(*) begin
    pattern_detected = 1'b0; // Default to not detected
    next_state = current_state; // Default to stay in the current state
    case (current_state)
        A: if (check == 0) next_state = B; // Transition logic for each state
            else next_state = A;
        B: if (check == 1) next_state = C;
            else next_state = B;
        C: if (check == 1) next_state = D;
            else next_state = B;
        D: if (check == 1) next_state = E;
            else next_state = B;    
        E: if (check == 0) next_state = F;
            else next_state = A;    
        F: if (check == 0) next_state = G;
            else next_state = A;    
        G: if (check == 0) next_state = H;
            else next_state = A;    
        H: if (check == 1) next_state = I;
            else next_state = B;    
        I: if (check == 1) next_state = J;
            else next_state = B;    
        J: if (check == 0) next_state = K;
            else next_state = A;
        K: if (check == 1) next_state = L;
            else next_state = B;    
        L: if (check == 1) next_state = M;
            else next_state = B;
        M: begin
            next_state = A; // Return to the initial state after detecting the pattern
            pattern_detected = 1'b1; // Indicate that the pattern has been detected
            end
        default: next_state = A; // Default case to handle any undefined states       
    endcase
end
endmodule