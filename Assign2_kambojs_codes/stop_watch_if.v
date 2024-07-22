module stop_watch_if(
    input wire clk, // Clock input signal
    input wire pattern_detected, // Signal indicating a pattern has been detected
    input wire clr, // Clear signal to reset the counter
    output wire [3:0] d3, d2, d1, d0); // 4-digit BCD outputs
   // Declaration of registers to hold the current value of each BCD digit
   reg [3:0] d3_curval, d2_curval, d1_curval, d0_curval;
   // Declaration of registers to hold the next value of each BCD digit
   reg [3:0] d3_nextval, d2_nextval, d1_nextval, d0_nextval;
   // Register block to update the current value of each BCD digit on the rising edge of the clock
   always @(posedge clk)
   begin
      d3_curval <= d3_nextval;
      d2_curval <= d2_nextval;
      d1_curval <= d1_nextval;
      d0_curval <= d0_nextval;
   end
   always @*
   begin
      // Default behavior: keep the previous value
      d0_nextval = d0_curval;
      d1_nextval = d1_curval;
      d2_nextval = d2_curval;
      d3_nextval = d3_curval;
      // If the clear signal is asserted, reset all digits to 0
      if (clr)
         begin
            d0_nextval = 4'b0;
            d1_nextval = 4'b0;
            d2_nextval = 4'b0;
            d3_nextval = 4'b0;
         end
      // If a pattern is detected, increment the counter
      else if (pattern_detected)
         begin
              // Increment the least significant digit (d0) if it's not already 9
              if (d0_curval != 9)
                 d0_nextval <= d0_curval + 1;
              else
                 begin
                    // If d0 is 9, reset it to 0 and increment the next digit (d1)
                    d0_nextval = 0;
                    if (d1_curval != 9)
                       d1_nextval <= d1_curval + 1;
                    else
                       begin
                          // Applying the same logic for d1, d2, and d3
                          d1_nextval = 0;
                          if (d2_curval != 9)
                             d2_nextval <= d2_curval + 1;
                          else
                             begin
                                d2_nextval = 0;
                                if (d3_curval != 9)
                                   d3_nextval <= d3_curval + 1;
                                else
                                   // If all digits are 9, reset the counter to 0
                                   d3_nextval <= 0;
                             end
                       end
                 end
         end
   end
   // Output logic: directly assign the current register values to the output
   assign d0 = d0_curval;
   assign d1 = d1_curval;
   assign d2 = d2_curval;
   assign d3 = d3_curval;
endmodule