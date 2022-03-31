module Counter #(parameter counter_bits = 3)(
    input   wire   i_clk,
    input   wire   i_RST,
    input   wire   count,
    output  reg    Counter_Flag
);

reg [counter_bits-1:0]   Counter_Value;

always @(posedge i_clk or negedge i_RST)
    begin
        if(!i_RST || !count)
            begin
               Counter_Value <= 'b0;
               Counter_Flag <= 1'b0;
            end
        else
            begin
                if (&Counter_Value)
                    begin
                        Counter_Flag <= 1'b1;
                        Counter_Value <= 'b0;
                    end
                else
                    begin
                        Counter_Value <= Counter_Value+1;
                        Counter_Flag <= 1'b0;
                    end
        end

      

    end

endmodule