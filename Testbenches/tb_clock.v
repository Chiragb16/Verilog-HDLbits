module top_module ( );
    reg clk;
    dut d1(.clk(clk));
    always begin
        #5 clk=~clk;
    end
    initial begin
        clk=0;
    end
endmodule

