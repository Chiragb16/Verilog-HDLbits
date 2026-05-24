module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum
);

    wire [99:0] c;

    genvar i;

    generate

        for(i=0; i<100; i=i+1) begin : stage

            if(i == 0) begin
                bcd_fadd fa (
                    .a   (a[i*4 +: 4]),
                    .b   (b[i*4 +: 4]),
                    .cin (cin),
                    .cout(c[i]),
                    .sum (sum[i*4 +: 4])
                );
            end

            else begin
                bcd_fadd fa (
                    .a   (a[i*4 +: 4]),
                    .b   (b[i*4 +: 4]),
                    .cin (c[i-1]),
                    .cout(c[i]),
                    .sum (sum[i*4 +: 4])
                );
            end

        end

    endgenerate

    assign cout = c[99];

endmodule
