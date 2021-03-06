//Verilog HDL for "Stimulator_IMP", "Digital_Stimulus_ST" "functional"


module Digital_Stimulus_ST (
		output reg EN_ST,
		output reg ANO_ST,
		output reg CAT_ST,
		output reg DIS_ST,	
		output reg[4:0] MAG_ST
);


// parameters 
parameter ST_period = 500; // in us
parameter CAT_phase = 150; // in us
parameter ANO_phase = 150; // in us
parameter DIS_phase = 5; // in us
parameter InterPulseDelay = 10; // in us
parameter MAG = 5'b11111; // in mA
parameter Ramping = 1'b0; 

real period_ns;
real CAT_phase_ns;
real ANO_phase_ns;
real DIS_phase_ns;
real IPD_ns;
real Rest_ns;
real en_extension_ns;


initial begin
	// convert to ns
	period_ns = ST_period * 1e3;
	CAT_phase_ns = CAT_phase * 1e3;
	ANO_phase_ns = ANO_phase * 1e3;
	DIS_phase_ns = DIS_phase * 1e3;
	IPD_ns = InterPulseDelay * 1e3;
	en_extension_ns = 10 * 1e3;
	Rest_ns = period_ns - CAT_phase_ns - ANO_phase_ns - DIS_phase_ns - IPD_ns - 2 * en_extension_ns;

	EN_ST <= 1'b0;
	ANO_ST <= 1'b0;
	CAT_ST <= 1'b0;
	DIS_ST <= 1'b0;
	if(Ramping == 1'b0)
		MAG_ST <= MAG;
	else
		MAG_ST <= 5'b00000;
end

always begin
	#(Rest_ns) ANO_ST <= 1'b0; CAT_ST <= 1'b0; DIS_ST <= 1'b0; EN_ST <= 1'b1;
	#(en_extension_ns) ANO_ST <= 1'b0; CAT_ST <= 1'b1; DIS_ST <= 1'b0; EN_ST <= 1'b1;
	#(CAT_phase_ns) ANO_ST <= 1'b0; CAT_ST <= 1'b0; DIS_ST <= 1'b0;	EN_ST <= 1'b1;
	#(IPD_ns) ANO_ST <= 1'b1; CAT_ST <= 1'b0; DIS_ST <= 1'b0; EN_ST <= 1'b1;
	#(ANO_phase_ns) ANO_ST <= 1'b0; CAT_ST <= 1'b0; DIS_ST <= 1'b1; EN_ST <= 1'b1;
	#(DIS_phase_ns) ANO_ST <= 1'b0; CAT_ST <= 1'b0; DIS_ST <= 1'b0; EN_ST <= 1'b1;
	#(en_extension_ns) ANO_ST <= 1'b0; CAT_ST <= 1'b0; DIS_ST <= 1'b0; EN_ST <= 1'b0;
	if(Ramping == 1'b1)
		MAG_ST <= MAG_ST + 1;
end

endmodule
