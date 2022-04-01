module ControlUnit #(parameter states_num = 3)(
    input   wire    i_clk,i_rst,
    input   wire    i_data_vaild,i_overflow,
    output  reg    o_load,o_shift,o_enable_counter,o_enable_clk

);
localparam  IDLE =  3'b001,
            LOAD =  3'b010,
            TRANS = 3'b100;

reg [2:0]       current_state,next_state;


always@ (posedge i_clk , negedge i_rst)
 begin
    if(!i_rst)
     begin
        current_state <= IDLE;
     end
    else
     begin
        current_state <= next_state;
     end
 end

 always@ (*)
  begin
    case(current_state)
        IDLE : 
         begin
            if(i_data_vaild)
             begin
                next_state <= LOAD;
             end
            else
             begin
                next_state <= IDLE;
             end
         end
        
        LOAD :
         begin
            next_state <= TRANS;
         end

        TRANS : 
         begin
            if(!i_overflow)
             begin
                next_state <= TRANS;
             end
            else if (i_data_vaild)
             begin
                next_state <= LOAD;
             end
            else
             begin
                next_state <= IDLE;
             end
        end
        default :
            next_state <= IDLE;
    endcase
  end

always@ (*)
 begin
    case(current_state)
        IDLE : 
            begin
                o_enable_clk = 1'b0;
                o_load = 1'b0;
                o_shift = 1'b0;
                o_enable_counter = 1'b0;
            end
        LOAD : 
            begin
                o_enable_clk = 1'b1;
                o_load = 1'b1;
                o_shift = 1'b0;
                o_enable_counter = 1'b1;
            end
        TRANS : 
            begin
                o_enable_clk = 1'b1;
                o_load = 1'b0;
                o_shift = 1'b1;
                o_enable_counter = 1'b1;
            end
        default : 
            begin
                o_enable_clk = 1'b0;
                o_load = 1'b0;
                o_shift = 1'b0;
                o_enable_counter = 1'b0;
            end

     endcase
end
endmodule