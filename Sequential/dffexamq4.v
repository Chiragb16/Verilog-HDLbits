module top_module (
    input clk,
    input x,
    output z
);

wire out1, out2, out3;

my_dff d1(clk, x ^ out1, out1);
my_dff d2(clk, x & ~out2, out2);
my_dff d3(clk, x | ~out3, out3);

assign z = ~(out1 | out2 | out3);

endmodule


module my_dff (
    input clk,
    input d,
    output reg q
);

initial q = 1'b0;

always @(posedge clk)
    q <= d;

endmodule


