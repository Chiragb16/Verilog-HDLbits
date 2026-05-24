module top_module ();
reg clk,rst,t;
    wire q;
    tff t1(clk,rst,t,q);
    always begin
        #5 clk=~clk;
    end
    initial begin
        clk=0;rst=1;t=0;
        #10 rst=0;t=1;
    end
endmodule

