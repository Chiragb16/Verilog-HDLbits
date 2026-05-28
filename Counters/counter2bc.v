module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    parameter S0=0,S1=1,S2=2,S3=3;
    reg [1:0]next_state,count;
    always @(posedge clk or posedge areset)begin
        if(areset)
            state<=S1;
        else if(train_valid)
            state<=next_state;
        else
            state<=state;
    end
    always @(*)begin
        case(state)
            S0:
                next_state=(train_taken)?S1:S0;
            S1:
                next_state=(train_taken)?S2:S0;
            S2:
                next_state=(train_taken)?S3:S1;
            S3:
                next_state=(train_taken)?S3:S2;
            default:next_state=S1;
        endcase
    end
endmodule





