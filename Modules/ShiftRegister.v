module ShiftRegister #(parameter width = 8)(
    input   wire                    i_clk,i_RST,
    input   wire                    i_load,i_shift,i_miso,
    input   wire    [width-1:0]     i_data,
    output  wire                    o_mosi
);

reg [width-1:0]     data,data_comb;

always@ (*)
 begin
    data_comb[width-2:0] = data>>1;
    data_comb[width-1] = i_miso;
 end

 always@ (posedge i_clk , negedge i_RST)
  begin
    if(!i_RST)
     begin
        data <= 'b0;
     end
    else
     begin
        if(i_load)
         begin
            data <= i_data;
         end
        else if (i_shift)
         begin
            data <= data_comb;
         end
     end
  end

assign o_mosi = data[0];
endmodule