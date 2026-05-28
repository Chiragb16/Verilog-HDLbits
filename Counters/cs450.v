module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9:0]count;
    always @(posedge clk)begin
        if(load)
            count<=data;
        else if(count!=0)begin
            count<=count-1'b1;
    end
        else
            count<=count;
end
    assign tc=(count==10'd0)?1:0;
    
endmodule

