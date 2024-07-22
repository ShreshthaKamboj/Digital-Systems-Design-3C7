module d_ff_reset(
    input wire clk, reset,
    input wire d,
    output reg q);
   // Code for asynchronous reset & clock 
   always @(posedge clk, posedge reset)     // For negative edge we can use negedge
      if (reset)
         q <= 1'b0;
      else
         q <= d;
// // Code for synchronous reset & clock
//    always@(posedge clk, posedge reset)
//    begin
//        if(reset)
//        begin
//            q = 1'b0;
//        end
//        else
//        begin
//            q = d;
//        end
//   end 
endmodule