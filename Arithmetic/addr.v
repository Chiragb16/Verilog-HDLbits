module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire [2:0]cout;   
    full_add a1(x[0],y[0],1'b0,sum[0],cout[0]);
    full_add a2(x[1],y[1],cout[0],sum[1],cout[1]);
    full_add a3(x[2],y[2],cout[1],sum[2],cout[2]);
    full_add a4(x[3],y[3],cout[2],sum[3],sum[4]);    
endmodule

module full_add( 
    input a, b, cin,
    output sum,cout );
	assign sum=a^b^cin;
    assign cout=(a&b)|(b&cin)|(cin&a);
endmodule


