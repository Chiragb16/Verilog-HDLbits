module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

    reg [1:0] state, next_state;
    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= A;
        else
            state <= next_state;
    end
    always @(*) begin
        case(state)

            A:
                next_state = x ? B : A;

            B:
                next_state = x ? C : D;

            C:
                next_state = x ? C : D;

            D:
                next_state = x ? C : D;

            default:
                next_state = A;

        endcase
    end


    assign z = (state == B || state == D);

endmodule
