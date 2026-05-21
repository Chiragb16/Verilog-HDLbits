module top_module(
    input clk,
    input areset,    
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    parameter LEFT  = 0,
              RIGHT = 1,
              FLEFT = 2,
              FRIGHT= 3,
              DIGL  = 4,
              DIGR  = 5,
              DEATH = 6;

    reg [2:0] state, next_state;
    integer i;

    
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= LEFT;
            i <= 0;
        end
        else begin
            state <= next_state;

            if(state == FLEFT || state == FRIGHT)
                i <= i + 1;
            else
                i <= 0;
        end
    end

    
    always @(*) begin
        case(state)

            LEFT: begin
                if(!ground)
                    next_state = FLEFT;
                else if(dig)
                    next_state = DIGL;
                else if(bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end

            RIGHT: begin
                if(!ground)
                    next_state = FRIGHT;
                else if(dig)
                    next_state = DIGR;
                else if(bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end

            DIGL: begin
                if(!ground)
                    next_state = FLEFT;
                else
                    next_state = DIGL;
            end

            DIGR: begin
                if(!ground)
                    next_state = FRIGHT;
                else
                    next_state = DIGR;
            end

            FLEFT: begin
                if(ground) begin
                    if(i > 19)
                        next_state = DEATH;
                    else
                        next_state = LEFT;
                end
                else
                    next_state = FLEFT;
            end

            FRIGHT: begin
                if(ground) begin
                    if(i > 19)
                        next_state = DEATH;
                    else
                        next_state = RIGHT;
                end
                else
                    next_state = FRIGHT;
            end

            DEATH:
                next_state = DEATH;

            default:
                next_state = LEFT;

        endcase
    end


    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == FLEFT || state == FRIGHT);
    assign digging    = (state == DIGL || state == DIGR);

endmodule
