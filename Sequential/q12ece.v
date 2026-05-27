module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output reg Z ); 
    wire q[0:7];
    diff d0(.clk(clk),.enable(enable),.d(S),.q(q[0]));
    diff d1(.clk(clk),.enable(enable),.d(q[0]),.q(q[1]));
    diff d2(.clk(clk),.enable(enable),.d(q[1]),.q(q[2]));
    diff d3(.clk(clk),.enable(enable),.d(q[2]),.q(q[3]));
    diff d4(.clk(clk),.enable(enable),.d(q[3]),.q(q[4]));
    diff d5(.clk(clk),.enable(enable),.d(q[4]),.q(q[5]));
    diff d6(.clk(clk),.enable(enable),.d(q[5]),.q(q[6]));
    diff d7(.clk(clk),.enable(enable),.d(q[6]),.q(q[7]));
    always @(*)begin
        case({A,B,C})
            3'd0:Z=q[0];
            3'd1:Z=q[1];
            3'd2:Z=q[2];
            3'd3:Z=q[3];
            3'd4:Z=q[4];
            3'd5:Z=q[5];
            3'd6:Z=q[6];
            3'd7:Z=q[7];
            default:Z=q[0];
        endcase
    end
    
endmodule

module diff(input clk,enable,d,output reg q);
    always @(posedge clk)begin
        if(enable)
        	q<=d;
        else
            q<=q;
    end
endmodule
