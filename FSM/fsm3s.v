module top_module(
    input clk,
    input in,
    input reset,
    output out); //
parameter A=2'd0,B=2'd1,C=2'd2,D=2'd3;
    reg [1:0]state,next_state;
    always @(posedge clk)begin
        if(reset)
            state<=A;
        else
            state<=next_state;
    end
    
    always @(*)begin
        case(state)
            A:begin
                if(in)
                    next_state<=B;
                else
                    next_state<=A;
            end
          		
            B:begin
                if(in)
                    next_state<=B;
                else
                    next_state<=C;
            end
            
            C:begin
                if(in)
                    next_state<=D;
                else
                    next_state<=A;
            end
            
            D:begin
                if(in)
                    next_state<=B;
                else
                    next_state<=C;
            end
            
            default:next_state<=A;
        endcase
    end
    assign out=(state==D)&&(next_state==C || next_state==B);

endmodule

