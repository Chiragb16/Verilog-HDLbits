module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output  [99:0] q); 
    reg [99:0]shift_reg;
    always @(posedge clk)begin
        if(load)begin
            shift_reg<=data;
        end
      else  if(ena)begin
            case(ena)
                2'b00:shift_reg<=shift_reg;
                2'b01:shift_reg<={shift_reg[0],shift_reg[99:1]};
                2'b10:shift_reg<={shift_reg[98:0],shift_reg[99]};
                2'b11:shift_reg<=shift_reg;
                default:shift_reg<=shift_reg;
            endcase
        end
        else begin
            shift_reg<=shift_reg;
        end
    end
    assign q=shift_reg;

endmodule
