module disp_hex_mux(
    input wire clk, reset,
    input wire [3:0] hex3, hex2, hex1, hex0,  // Hexadecimal digits inputs
    input wire [3:0] dp_in,                   // Decimal points for each digit, active low
    output reg [3:0] an,                      // Active-low enable signals for each of the 4 digits
    output reg [7:0] sseg                     // Seven-segment display output, including decimal point
);
   localparam N = 18;  // Constant for counter size to achieve ~800 Hz refresh rate with a 50 MHz clock
   reg [N-1:0] q_reg = 0;  // N-bit counter register, initialized to 0
   wire [N-1:0] q_next;    // Next state of the counter
   reg [3:0] hex_in = 0;   // Current hex digit to display, initialized to 0
   reg dp = 1;             // Current decimal point state, initialized to 1 (off)
   // N-bit counter for multiplexing control
   always @(posedge clk or posedge reset)
      if (reset)
         q_reg <= 0;
      else
         q_reg <= q_next;
   assign q_next = q_reg + 1;
   // Multiplexing control based on the 2 MSBs of the counter
   always @*
      case (q_reg[N-1:N-2])
         2'b00: {an, hex_in, dp} = {4'b1110, hex0, dp_in[0]};
         2'b01: {an, hex_in, dp} = {4'b1101, hex1, dp_in[1]};
         2'b10: {an, hex_in, dp} = {4'b1011, hex2, dp_in[2]};
         default: {an, hex_in, dp} = {4'b0111, hex3, dp_in[3]};
      endcase
   // hex to seven-segment led display
   always @*
   begin
      case(hex_in)
         4'h0: sseg[6:0] = 7'b1000000;
         4'h1: sseg[6:0] = 7'b1111001;
         4'h2: sseg[6:0] = 7'b0100100;
         4'h3: sseg[6:0] = 7'b0110000;
         4'h4: sseg[6:0] = 7'b0011001;
         4'h5: sseg[6:0] = 7'b0010010;
         4'h6: sseg[6:0] = 7'b0000010;
         4'h7: sseg[6:0] = 7'b1111000;
         4'h8: sseg[6:0] = 7'b0000000;
         4'h9: sseg[6:0] = 7'b0010000;
         4'ha: sseg[6:0] = 7'b0001000;
         4'hb: sseg[6:0] = 7'b0000011;
         4'hc: sseg[6:0] = 7'b1000110;
         4'hd: sseg[6:0] = 7'b0100001;
         4'he: sseg[6:0] = 7'b0000110;
         4'hf: sseg[6:0] = 7'b0001110;
         default: sseg[6:0] = 7'b1111111;  
     endcase
     sseg[7] = dp; // Corrected to properly handle active-low logic for decimal point
   end
endmodule