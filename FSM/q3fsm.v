module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    parameter A = 0,
              B = 1;

    reg state;
    reg [2:0] out_check;
    reg [1:0] count;

    always @(posedge clk) begin

        if(reset) begin
            state <= A;
            out_check <= 0;
            count <= 0;
            z <= 0;
        end

        else begin

            case(state)

                A: begin
                    z <= 0;

                    if(s) begin
                        state <= B;
                        count <= 0;
                        out_check <= 0;
                    end
                end

                B: begin

                   
                    out_check <= {out_check[1:0], w};

                    if(count == 2) begin

                        case({out_check[1:0], w})

                            3'b011,
                            3'b101,
                            3'b110:
                                z <= 1;

                            default:
                                z <= 0;

                        endcase

                        count <= 0;
                    end

                    else begin
                        count <= count + 1;
                        z <= 0;
                    end
                end

            endcase
        end
    end

endmodule
