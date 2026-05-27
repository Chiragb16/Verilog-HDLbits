module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output reg [31:0] q
); 
    reg [31:0]q_next;
    always @(posedge clk)begin
        if(reset)
            q<=32'h1;
        else 
            q<=q_next;
    end
    
    always @(*)begin
        q_next=q[32:1];
        q_next[32]=q[0];
        q_next[22]=q[23]^q[0];
        q_next[2]=q[3]^q[0];
        q_next[1]=q[2]^q[0];
    end
endmodule

