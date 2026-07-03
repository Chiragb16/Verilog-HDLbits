module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output [3:0] q); 
    reg [3:0]shift_reg;
    always @(posedge clk or posedge areset)begin
        if(areset)
            shift_reg<=4'd0;
        else begin
            if(load)begin
                shift_reg<=data;
            end
            if(ena)begin
                 shift_reg<={1'b0,shift_reg[3:1]};
            end
            if(load==1 && ena==1)begin
                shift_reg<=data;
            end
        end
    end
    
    assign q=shift_reg;

endmodule






