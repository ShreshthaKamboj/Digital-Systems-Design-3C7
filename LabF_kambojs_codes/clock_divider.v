module clock_divider(
    input clk_in,  // Input clock, assumed to be 50MHz based on the context
    input rst_n,   // Asynchronous reset, active low
    output reg clk_out = 0);  // Output clock, initialized to 0, target is 1Hz after division
// Parameter for defining the division factor. Set to 25,000,000 for a 50MHz clock to achieve 1Hz.
parameter DIVIDE_BY = 25000000; // Division factor to toggle the output clock
// Define a 25-bit counter to count up to 25,000,000
reg [24:0] counter = 0; // Counter variable to store intermediate counts
// Always block triggered on the rising edge of clk_in or the falling edge of rst_n
always @(posedge clk_in or negedge rst_n) begin
    if (!rst_n) begin // If reset is active (low)
        counter <= 0;      // Reset the counter to 0
        clk_out <= 0;      // Reset the output clock to 0
    end else begin
        if (counter == DIVIDE_BY-1) begin // If counter reaches the division value minus 1
            counter <= 0;                 // Reset the counter
            clk_out <= ~clk_out;         // Toggle the output clock
        end else begin
            counter <= counter + 1;      // Increment the counter
        end
    end
end
endmodule
