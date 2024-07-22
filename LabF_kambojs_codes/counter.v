module counter(
        input clk, rst_n, max_tick, msb_in,
        output reg [12:0] ones_count, // Adjusted to 13 bits for the 13-bit LFSR
        output reg [12:0] zeros_count ); // Adjusted to 13 bits for the 13-bit LFSR
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset the counters when the reset signal is asserted
            ones_count <= 13'b0;
            zeros_count <= 13'b0;
        end else if (max_tick) begin
            // Reset the counters when the LFSR completes a full cycle
            ones_count <= 13'b0;
            zeros_count <= 13'b0;
        end else begin
            // Increment the appropriate counter based on the MSB input
            if (msb_in)
                ones_count <= ones_count + 1;
            else
                zeros_count <= zeros_count + 1;
        end
    end
endmodule