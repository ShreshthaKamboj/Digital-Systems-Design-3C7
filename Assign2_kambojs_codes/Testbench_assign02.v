//module Testbench_assign02;
//reg clk_tb;
//reg rst_tb;
//wire [3:0] an_tb;
//wire [6:0] sseg_tb;
//wire p;
////wire [16:0] Q_d;
//// Instantiate the top module
//top_module uut(
//    .clk(clk_tb),
//    .rst(rst_tb),
//    .an(an_tb),
//    .pattern_detected(p),
//    .sseg(sseg_tb));
////    .Q_d(Q_d));
//// Clock generation
//always #10 clk_tb = ~clk_tb;  // Generate a clock with a period of 20ns
//initial begin
//    // Initialize signals
//    clk_tb = 0;  // Initial state of the clock
//    rst_tb = 1;  // Assert reset initially
//    // Reset the system
//    #20 rst_tb = 0;  // De-assert reset after 20ns
//    #2621420;  // Run simulation for 2621420ns to observe multiple cycles
//    $finish;  // End the simulation
//end
//endmodule