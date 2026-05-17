module top_module (input x, input y, output z);
wire z1,z2,z3,z4,out1,out2;
    qa a1(.x(x),.y(y),.z(z1));
    qb b1(.x(x),.y(y),.z(z2));
    qa a2(.x(x),.y(y),.z(z3));
    qb b2(.x(x),.y(y),.z(z4));
    assign out1=z1|z2;
    assign out2=z3&z4;
    assign z=out1^out2;
endmodule

module qb(input x,input y,output z);
    assign z = ~(x^y);
endmodule

module qa(input x,input y,output z);
    assign  z = (x^y) & x;
endmodule


