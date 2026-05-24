module top_module();
reg clk,in;
reg [2:0]s;
wire out;
    q7 uut(clk,in,s,out);
    always begin
        #5 clk=~clk;
    end
    
    initial begin
	clk=0;in=0;s=2;
        #10 s=6;
        #10 in=1;s=2;
        #10 in=0;s=7;
        #10 in=1;s=0;
        #30 in=0;
    end
endmodule

