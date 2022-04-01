module ClockDivider #(parameter width=8)(
    input   wire                    i_clk,i_rst,
    input   wire    [width-1:0]     div_by,
    output  wire                    o_clk
);

reg     [width-1:0]     count,count_comp;

always@ (posedge i_clk , negedge i_rst)
 begin
    if (!i_rst)
     begin
        count <= 'b0;
     end
    else
     begin
        count <= count_comp;
     end
end

always@ (*)
 begin
    count = count +1;
 end

assign o_clk = count[div_by];

endmodule