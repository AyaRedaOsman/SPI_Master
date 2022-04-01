module SPI_Master #(parameter width = 8 , Div_width =8)(
    input   wire                        CLK,CPOL,CPHA,RST,Data_Valid,MISO,
    input   wire    [width-1:0]         Data,
    input   wire    [Div_width-1:0]     div_by,
    output  wire                        MOSI,SCLK
);

wire    div_clk,enable_clk,load,shift,enternal_clk,count,overflow;

ClockDivider u0_divider(
    .i_clk(CLK),
    .i_rst(RST),
    .div_by(div_by),
    .o_clk(div_clk)
);

ClockLogic u0_logic(
    .i_clk(div_clk),
    .i_cpha(CPHA),
    .i_cpol(CPOL),
    .o_enternal_clk(enternal_clk)
);

Counter u0_counter(
    .i_clk(enternal_clk),
    .i_RST(RST),
    .count(count),
    .Counter_Flag(overflow)
);

ControlUnit u0_controlunit(
    .i_clk(enable_clk),
    .i_rst(RST),
    .i_overflow(overflow),
    .i_data_vaild(Data_Valid),
    .o_shift(shift),
    .o_load(load),
    .o_enable_clk(enable_clk),
    .o_enable_counter(count)
);

ShiftRegister u0_shift(
    .i_clk(enternal_clk),
    .i_RST(RST),
    .i_load(load),
    .i_shift(shift),
    .i_miso(MISO),
    .i_data(Data),
    .o_mosi(MOSI)
);

assign SCLK = (enable_clk)?div_clk:CPOL;

endmodule