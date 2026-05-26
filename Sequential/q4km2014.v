module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
	wire q1,q2,q3;      
    myyydff da1(.d(in),.rst(resetn),.clk(clk),.q(q1));
    myyydff da2(.d(q1),.rst(resetn),.clk(clk),.q(q2));
    myyydff da3(.d(q2),.rst(resetn),.clk(clk),.q(q3));
    myyydff da4(.d(q3),.rst(resetn),.clk(clk),.q(out));
        
endmodule

module myyydff(d,rst,clk,q);
    input d,rst,clk;
    output reg q;
    always @(posedge clk)begin
        if(!rst)
            q<=0;
        else
            q<=d;
    end
endmodule


