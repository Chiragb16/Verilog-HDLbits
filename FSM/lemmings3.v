module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );
    parameter LEFT=0,RIGHT=1,Fall_Left=2,Fall_Right=3,Dig_Left=4,Dig_Right=5;
    reg [2:0]state,next_state;
    always @(posedge clk or posedge areset)begin
        if(areset)
            state<=LEFT;
        else
            state<=next_state;
    end
            
            always @(*)begin
                case(state)
                    LEFT:begin
                        if(!ground)
    				next_state = Fall_Left;
						else if(dig)
    				next_state = Dig_Left;
					else if(bump_left)
    				next_state = RIGHT;
                    else
   					 next_state = LEFT;
                    end
                    
                    Dig_Left:next_state=(ground)?Dig_Left:Fall_Left;
                    
                    Fall_Left:next_state=(ground)?LEFT:Fall_Left;
                    
                    RIGHT: begin
    							if(!ground)
        							next_state = Fall_Right;
  							  else if(dig)
        							next_state = Dig_Right;
    							else if(bump_right)
      							   next_state = LEFT;
    									else
     										   next_state = RIGHT;
											end
                       
                    Dig_Right:next_state=(ground)?Dig_Right:Fall_Right;
                    
                    Fall_Right:next_state=(ground)?RIGHT:Fall_Right;
                endcase
            end
                    
    assign walk_left=(state==LEFT);
    assign walk_right=(state==RIGHT);
    assign aaah=(state==Fall_Left) || (state==Fall_Right);
    assign digging=((state==Dig_Left)||(state==Dig_Right));
                          
endmodule

