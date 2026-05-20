module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    parameter LOW      = 3'd0,
              MID1_R   = 3'd1,
              MID2_R   = 3'd2,
              TOP      = 3'd3,
              MID2_F   = 3'd4,
              MID1_F   = 3'd5;

    reg [2:0] state, next_state;

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= LOW;
        else
            state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        case(state)

            LOW: begin
                if (s == 3'b001)
                    next_state = MID1_R;
                else
                    next_state = LOW;
            end

            MID1_R: begin
                if (s == 3'b011)
                    next_state = MID2_R;
                else if (s == 3'b000)
                    next_state = LOW;
                else
                    next_state = MID1_R;
            end

            MID2_R: begin
                if (s == 3'b111)
                    next_state = TOP;
                else if (s == 3'b001)
                    next_state = MID1_F;
                else
                    next_state = MID2_R;
            end

            TOP: begin
                if (s == 3'b011)
                    next_state = MID2_F;
                else
                    next_state = TOP;
            end

            MID2_F: begin
                if (s == 3'b001)
                    next_state = MID1_F;
                else if (s == 3'b111)
                    next_state = TOP;
                else
                    next_state = MID2_F;
            end

            MID1_F: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b011)
                    next_state = MID2_R;
                else
                    next_state = MID1_F;
            end

            default: next_state = LOW;

        endcase
    end

    // Output logic
    always @(*) begin

        fr1 = 0;
        fr2 = 0;
        fr3 = 0;
        dfr = 0;

        case(state)

            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end

            MID1_R: begin
                fr1 = 1;
                fr2 = 1;
            end

            MID2_R: begin
                fr1 = 1;
            end

            TOP: begin
            end

            MID2_F: begin
                fr1 = 1;
                dfr = 1;
            end

            MID1_F: begin
                fr1 = 1;
                fr2 = 1;
                dfr = 1;
            end

        endcase
    end

endmodule
