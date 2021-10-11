//Verilog HDL for "MultiChannel_EMG_Model", "ClockGen" "functional"
`timescale 1ns/1ps

module ClockGen (CLK, CLKB );

output CLK, CLKB;
reg CLK;


parameter real FREQ_KHz = 32; //in KHz
parameter real DUTY = 50; // Duty cycle


real clk_pd; // convert to ns
real clk_on;
real clk_off;

assign CLKB = ~CLK;

initial begin
	clk_pd = 1.0/(FREQ_KHz * 1e3) * 1e9; // convert to ns
	clk_on =  DUTY/100.0 * clk_pd;
	clk_off = (100.0 - DUTY)/100.0 * clk_pd;
	CLK <= 0;
end	


always begin
		#(clk_off) CLK <= ~CLK;
		#(clk_on) CLK <= ~CLK;
end

endmodule
