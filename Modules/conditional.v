module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0]out1,out2;
    assign out1=(a>b)?b:a;
    assign out2=(c>d)?d:c;
    assign min=(out1>out2)?out2:out1;
endmodule

