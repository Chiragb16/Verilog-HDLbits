module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(posedge clk, posedge areset) begin  
        if(areset)
            state<=B;
        else
            state<=next_state;
    end

    always @(*) begin   
        if(in==1'b1)
                next_state<=state;
            else begin
                if(state)
                    next_state<=A;
                else
                    next_state<=B;
            end
    end
            assign out=(state==B)?1:0;

endmodule

