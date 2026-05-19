module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output reg[3:0] q);
    initial q<=4'd1;
    always @(posedge clk)begin
        if(reset | q==4'hA )
            q<=4'd1;
        else
            q<=q+1;
    end
endmodule

