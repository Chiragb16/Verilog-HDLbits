module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output  [4:0] q
); 
    wire qt0,qt1;
    assign qt0=1'b0^q[0];
    assign qt1=q[3]^q[0];
    mydff d1(.clk(clk),.reset(reset),.d(qt0),.q(q[4]));
    mydff d2(.clk(clk),.reset(reset),.d(q[4]),.q(q[3]));
    mydff d3(.clk(clk),.reset(reset),.d(qt1),.q(q[2]));
    mydff d4(.clk(clk),.reset(reset),.d(q[2]),.q(q[1]));
    mydff1 d5(.clk(clk),.reset(reset),.d(q[1]),.q(q[0]));
             
endmodule

module mydff(clk,reset,d,q);
    input clk,reset,d;
    output reg q;
    always @(posedge clk)begin
        if(reset)
            q<=1'b0;
        else
            q<=d;
    end
endmodule
module mydff1(clk,reset,d,q);
    input clk,reset,d;
    output reg q;
    always @(posedge clk)begin
        if(reset)
            q<=1'b1;
        else
            q<=d;
    end
endmodule


