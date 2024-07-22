module top_module(
    input wire clk,
    input wire rst,
    input wire en,
    output wire [3:0] an,
    output wire [6:0] sseg
    );  
//    output wire [16:0] Q_d);
wire lfsr_bit;
wire [3:0]  d3, d2, d1, d0;;
wire slow_clk;
wire pattern_detected;
// Instantiating the Clock Divider Module
clock_divider clock(
    .clk_in(clk),
    .rst_n(rst),
    .clk_out(slow_clk));
// Instantiating the LFSR Module
lfsr_17bit LFSR(
    .clk(clk),
    .rst_n(rst),
    .sh_en(en),
    .Q_out(lfsr_bit));
//    .Q_d(Q_d));
// Instantiating the Moore Model Finite State Machine
moore_seq_detector FSM(
    .clk(clk),
    .rst_n(rst),
    .check(lfsr_bit),
    .pattern_detected(pattern_detected));
// Instantiating the Counter Module
stop_watch_if counter(
    .clk(clk),
    .pattern_detected(pattern_detected),
    .clr(rst),
    .d3(d3),.d2(d2),.d1(d1),.d0(d0));
// Instantiating the Seven Segment Module
disp_hex_mux display(
    .clk(clk),
    .reset(rst),
    .hex3(d3), .hex2(d2), .hex1(d1), .hex0(d0),
    .dp_in(4'b1101),
    .an(an),
    .sseg(sseg)
);
endmodule