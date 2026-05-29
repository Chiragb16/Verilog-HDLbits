module top_module (
    input clk,
    input reset,
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack
);

    parameter S0   = 0,
              S1   = 1,
              S11  = 2,
              S110 = 3,
              LOAD0= 4,
              LOAD1= 5,
              LOAD2= 6,
              LOAD3= 7,
              COUNT= 8,
              DONE = 9;

    reg [3:0] state, next_state;

    reg [3:0] delay;
    reg [13:0] cycle_count;

    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(posedge clk) begin
        if (reset) begin
            delay <= 0;
            cycle_count <= 0;
        end
        else begin
            case(state)

                LOAD0: delay[3] <= data;
                LOAD1: delay[2] <= data;
                LOAD2: delay[1] <= data;
                LOAD3: delay[0] <= data;

                COUNT: begin
                    if (cycle_count < ((delay + 1) * 1000 - 1))
                        cycle_count <= cycle_count + 1;
                end

                default:
                    cycle_count <= 0;

            endcase
        end
    end

    always @(*) begin
        case(state)

            S0:   next_state = data ? S1   : S0;
            S1:   next_state = data ? S11  : S0;
            S11:  next_state = data ? S11  : S110;
            S110: next_state = data ? LOAD0: S0;

            LOAD0: next_state = LOAD1;
            LOAD1: next_state = LOAD2;
            LOAD2: next_state = LOAD3;
            LOAD3: next_state = COUNT;

            COUNT:
                next_state =
                    (cycle_count == ((delay + 1) * 1000 - 1))
                    ? DONE : COUNT;

            DONE:
                next_state = ack ? S0 : DONE;

            default:
                next_state = S0;

        endcase
    end

    assign counting = (state == COUNT);
    assign done     = (state == DONE);

    assign count =
        delay - (cycle_count / 1000);

endmodule
