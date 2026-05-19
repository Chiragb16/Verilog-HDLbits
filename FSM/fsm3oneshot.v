module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;
    assign next_state[A] = (state[A]&(~in))|(state[C]&(~in));
    assign next_state[B] = (state[B]&in)|(state[D]&in)|(state[A]&in);
    assign next_state[C] = (state[B]&(~in))|(state[D]&(~in));
    assign next_state[D] = state[C]&in;

    assign out = (state[D]==1) && ((next_state[C]==1) || (next_state[B]==1));

endmodule


