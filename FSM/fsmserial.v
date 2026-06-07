module top_module(
    input clk,
    input in,
    input reset,
    output done
);

    localparam IDLE  = 3'd0,
               DATA  = 3'd1,
               STOP  = 3'd2,
               DONE  = 3'd3,
               ERROR = 3'd4;

    reg [2:0] state, next_state;
    reg [3:0] count;

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(posedge clk) begin
        if (reset)
            count <= 0;
        else if (state == DATA)
            count <= count + 1;
        else
            count <= 0;
    end

    always @(*) begin
        case (state)
            IDLE:
                next_state = in ? IDLE : DATA;
            DATA:
                next_state = (count == 7) ? STOP : DATA;
            STOP:
                next_state = in ? DONE : ERROR;
            DONE:
                next_state = in ? IDLE : DATA;
            ERROR:
                next_state = in ? IDLE : ERROR;

            default:
                next_state = IDLE;
        endcase
    end

    assign done = (state == DONE);

endmodule