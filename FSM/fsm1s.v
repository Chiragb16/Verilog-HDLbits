// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

	parameter A=1'b0,B=1'b1;
    reg present_state;
		always @(posedge clk) begin
            if(reset)begin
        		present_state <= B;
            	out<=B;
            end
   			 else begin
        		case(present_state)

            A: begin
                if(in)begin
                    present_state <= A;
              		out<=A;
                end
                else begin
                    present_state <= B;
                	out<=B;
                end
            end

            B: begin
                if(in)begin
                    present_state <= B;
                    out<=B;
                end
                else begin
                    present_state <= A;
                    out<=A;
                end
            end

        endcase
    		end

        end

endmodule

