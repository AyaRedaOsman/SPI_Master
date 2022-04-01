module ClockLogic (
    input   wire    i_clk,i_cpol,i_cpha,
    output  reg     o_enternal_clk
);

assign  mode = {i_cpha,i_cpol};

/*
 Mode | Clock Polarity (CPOL/CKP) | Clock Phase (CPHA)
  0   |             0             |        0
  1   |             0             |        1
  2   |             1             |        0
  3   |             1             |        1
*/

always@ (*)
 begin
    if ((mode == 2'b01) || (mode == 2'b10))
     begin
        o_enternal_clk = ~i_clk;
     end
    else
     begin
        o_enternal_clk = i_clk;
     end
 end

endmodule