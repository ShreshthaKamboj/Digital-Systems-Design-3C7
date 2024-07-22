`timescale 1ns / 1ps

module topmodule(
    input wire [5:0] A, B,
    input wire [2:0] fxn,
    output reg [5:0] led,
    output reg bool,
    output reg c_out,
    output reg overflow
);
// wires defined to hold different values at different points of time for different instantiations
wire [5:0] sum_add, sum_sub, Neg_A, Neg_B, sum_xnor;
wire c_out_add, c_out_sub, overflow_add, overflow_sub, NegA_cout, NegA_overflow;
wire NegB_cout, NegB_overflow, lt_true, lt_eq, lt_gr;

// Instantiate the adder
six_bit_ripple_adder add(.x(A), .y(B), .sel(1'b0), .overflow(overflow_add), .c_out(c_out_add), .sum(sum_add));

// Instantiate the subtractor
six_bit_ripple_adder sub(.x(A), .y(B), .sel(1'b1), .overflow(overflow_sub), .c_out(c_out_sub), .sum(sum_sub));

// Negation A
six_bit_ripple_adder NegA(.x(~A), .y(6'b000001), .sel(1'b0), .overflow(NegA_overflow), .c_out(NegA_cout), .sum(Neg_A));

// Negation B
six_bit_ripple_adder NegB(.x(6'b000000), .y(B), .sel(1'b1), .overflow(NegB_overflow), .c_out(NegB_cout), .sum(Neg_B));

// A XNOR B
AxnorB ab_xnor(.a(A), .b(B), .value(sum_xnor));

// A less than B
gt_eq lt(.a({2'b00, A}),.b({2'b00, B}),.answer(lt_true),.equal(lt_eq),.greater(lt_gr));

always @(*) begin
    case(fxn)
        3'b000: begin // Pass A
            led = A;
            bool = 1'b0;
            c_out = 0;
            overflow = 0;
        end
        3'b001: begin // Pass B
            led = B;
            bool = 1'b0;
            c_out = 0;
            overflow = 0;
        end
        3'b010: begin // Neg A
            led = Neg_A;
            bool = 1'b0;
            c_out = NegA_cout;
            overflow = NegA_overflow;
        end
        3'b011: begin // Neg B
            led = Neg_B;
            bool = 1'b0;
            c_out = NegB_cout;
            overflow = NegB_overflow;
        end
        3'b100: begin // A < B 
            led = 6'b000000;
            bool = ~lt_true;
            c_out = 0;
            overflow = 0;
        end
        3'b101: begin // A XNOR B 
            led = sum_xnor;
            bool = 1'b0;
            c_out = 0;
            overflow = 0;
        end
        3'b110: begin // Add
            led = sum_add;
            bool = 1'b0;
            c_out = c_out_add;
            overflow = overflow_add;
        end
        3'b111: begin // Subtract
            led = sum_sub;
            bool = 1'b0;
            c_out = c_out_sub;
            overflow = overflow_sub;
        end
    endcase
end

endmodule
