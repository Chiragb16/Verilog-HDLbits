module top_module(
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output done
);

    parameter S0=0, S1=1, S2=2, S3=3;

    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            out_bytes <= 24'd0;
        end
        else begin
            case (state)
                S0: begin
                    if (in[3]) begin
                        state <= S1;
                        out_bytes[23:16] <= in;
                    end
                end

                S1: begin
                    state <= S2;
                    out_bytes[15:8] <= in;
                end

                S2: begin
                    state <= S3;
                    out_bytes[7:0] <= in;
                end

                S3: begin
                    state <= in[3] ? S1 : S0;

                    if (in[3])
                        out_bytes[23:16] <= in;
                end
            endcase
        end
    end

    assign done = (state == S3);

endmodule
