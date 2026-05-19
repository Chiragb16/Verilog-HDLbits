module top_module (
    input clk,
    input reset,
    output [3:1] ena,
    output [15:0] q
);

assign ena[1] = (q[3:0] == 4'd9);

assign ena[2] = (q[7:4] == 4'd9) &&
                (q[3:0] == 4'd9);

assign ena[3] = (q[11:8] == 4'd9) &&
                (q[7:4] == 4'd9) &&
                (q[3:0] == 4'd9);

dec d1 (.clk(clk), .reset(reset), .enable(1'b1),   .q(q[3:0]));
dec d2 (.clk(clk), .reset(reset), .enable(ena[1]), .q(q[7:4]));
dec d3 (.clk(clk), .reset(reset), .enable(ena[2]), .q(q[11:8]));
dec d4 (.clk(clk), .reset(reset), .enable(ena[3]), .q(q[15:12]));

endmodule



module dec(
    input clk,
    input reset,
    input enable,
    output reg [3:0] q
);

always @(posedge clk) begin
    if(reset)
        q <= 4'd0;
    else if(enable) begin
        if(q == 4'd9)
            q <= 4'd0;
        else
            q <= q + 1;
    end
end

endmodule

