`timescale 1ns / 1ps
module toplevel(
    input clk, // Clock signal
    input reset, // Reset signal
    input [4:0] button_input, // 5-bit input for buttons
    output [3:0] anode_sel, // 4-bit output for anode selection in a 7-segment display
    output [6:0] led_out); // 7-bit output for LED segments
    wire UP, LEFT, DOWN, RIGHT, CENTRE;// Wire declarations for button states
    wire [7:0] Q;// 8-bit wire for storing the current state
    reg [7:0] Q_next;// 8-bit register for storing the next state
    wire [4:0] buttons;// Wire for debounced button inputs
    // Instantiate a debouncer module for button inputs
    debouncer db(.clk(clk), .reset(reset), .button_in(button_input), .button_out(buttons));
    // Instantiate flip-flops with reset for each bit of Q
    d_ff_reset DFF0(.clk(clk), .reset(reset), .d(Q_next[0]), .q(Q[0]));
    d_ff_reset DFF1(.clk(clk), .reset(reset), .d(Q_next[1]), .q(Q[1]));
    d_ff_reset DFF2(.clk(clk), .reset(reset), .d(Q_next[2]), .q(Q[2]));
    d_ff_reset DFF3(.clk(clk), .reset(reset), .d(Q_next[3]), .q(Q[3]));
    d_ff_reset DFF4(.clk(clk), .reset(reset), .d(Q_next[4]), .q(Q[4]));
    d_ff_reset DFF5(.clk(clk), .reset(reset), .d(Q_next[5]), .q(Q[5]));
    d_ff_reset DFF6(.clk(clk), .reset(reset), .d(Q_next[6]), .q(Q[6]));
    d_ff_reset DFF7(.clk(clk), .reset(reset), .d(Q_next[7]), .q(Q[7])); 
    // Assign button states to corresponding wires
    assign UP = buttons[0];
    assign LEFT = buttons[1];
    assign DOWN = buttons[2];
    assign RIGHT = buttons[3];
    assign CENTRE = buttons[4]; 
    always @(posedge clk or posedge reset) begin// Sequential logic to update Q_next based on button inputs
        if (reset) begin
            Q_next <= 8'b0; // Reset Q_next to 0
        end else begin
            if(UP == 1'b1 || RIGHT == 1'b1) begin
                Q_next <= Q + 8'b00000001; // Increment Q if UP or RIGHT is pressed
            end else if(DOWN == 1'b1 || LEFT == 1'b1) begin
                Q_next <= Q - 8'b00000001; // Decrement Q if DOWN or LEFT is pressed
            end else if(CENTRE == 1'b1) begin
                Q_next <= 8'b00010110; // Set Q to 22 if CENTRE is pressed
            end else begin
                Q_next <= Q; // Keep Q unchanged if no buttons are pressed
            end
        end
    end
    // Instantiate a seven-segment controller module
    seven_segment_controller svc(.clk(clk), .reset(reset), .temp(Q), .anode_select(anode_sel), .LED_out(led_out)); 
endmodule