//Verilog HDL for "MultiChannel_EMG_Model", "ClockGenMultiFreq" "functional"


module ClockGenMultiFreq (output 
CLK1, CLKB1, 
CLK2, CLKB2,
CLK3, CLKB3,
CLK4, CLKB4,
CLK5, CLKB5,
CLK6, CLKB6,
CLK7, CLKB7,
CLK8, CLKB8,
CLK9, CLKB9,
CLK10, CLKB10,
CLK11, CLKB11,
CLK12, CLKB12,
CLK13, CLKB13,
CLK14, CLKB14,
CLK15, CLKB15,
CLK16, CLKB16
);


parameter fchop1 = 32;
parameter df = 4;
parameter fchop2 = fchop1+df;
parameter fchop3 = fchop1+2*df;
parameter fchop4 = fchop1+3*df;
parameter fchop5 = fchop1+4*df;
parameter fchop6 = fchop1+5*df;
parameter fchop7 = fchop1+6*df;
parameter fchop8 = fchop1+7*df;
parameter fchop9 = fchop1+8*df;
parameter fchop10 = fchop1+9*df;
parameter fchop11 = fchop1+10*df;
parameter fchop12 = fchop1+11*df;
parameter fchop13 = fchop1+12*df;
parameter fchop14 = fchop1+13*df;
parameter fchop15 = fchop1+14*df;
parameter fchop16 = fchop1+15*df;
parameter DUTY = 50;

ClockGen #(.FREQ_KHz(fchop1), .DUTY(DUTY)) CLK1Gen (
.CLK(CLK1),
.CLKB(CLKB1)
);

ClockGen #(.FREQ_KHz(fchop2), .DUTY(DUTY)) CLK2Gen (
.CLK(CLK2),
.CLKB(CLKB2)
);

ClockGen #(.FREQ_KHz(fchop3), .DUTY(DUTY)) CLK3Gen (
.CLK(CLK3),
.CLKB(CLKB3)
);

ClockGen #(.FREQ_KHz(fchop4), .DUTY(DUTY)) CLK4Gen (
.CLK(CLK4),
.CLKB(CLKB4)
);

ClockGen #(.FREQ_KHz(fchop5), .DUTY(DUTY)) CLK5Gen (
.CLK(CLK5),
.CLKB(CLKB5)
);

ClockGen #(.FREQ_KHz(fchop6), .DUTY(DUTY)) CLK6Gen (
.CLK(CLK6),
.CLKB(CLKB6)
);

ClockGen #(.FREQ_KHz(fchop7), .DUTY(DUTY)) CLK7Gen (
.CLK(CLK7),
.CLKB(CLKB7)
);

ClockGen #(.FREQ_KHz(fchop8), .DUTY(DUTY)) CLK8Gen (
.CLK(CLK8),
.CLKB(CLKB8)
);

ClockGen #(.FREQ_KHz(fchop9), .DUTY(DUTY)) CLK9Gen (
.CLK(CLK9),
.CLKB(CLKB9)
);

ClockGen #(.FREQ_KHz(fchop10), .DUTY(DUTY)) CLK10Gen (
.CLK(CLK10),
.CLKB(CLKB10)
);

ClockGen #(.FREQ_KHz(fchop11), .DUTY(DUTY)) CLK11Gen (
.CLK(CLK11),
.CLKB(CLKB11)
);

ClockGen #(.FREQ_KHz(fchop12), .DUTY(DUTY)) CLK12Gen (
.CLK(CLK12),
.CLKB(CLKB12)
);

ClockGen #(.FREQ_KHz(fchop13), .DUTY(DUTY)) CLK13Gen (
.CLK(CLK13),
.CLKB(CLKB13)
);

ClockGen #(.FREQ_KHz(fchop14), .DUTY(DUTY)) CLK14Gen (
.CLK(CLK14),
.CLKB(CLKB14)
);

ClockGen #(.FREQ_KHz(fchop15), .DUTY(DUTY)) CLK15Gen (
.CLK(CLK15),
.CLKB(CLKB15)
);

ClockGen #(.FREQ_KHz(fchop16), .DUTY(DUTY)) CLK16Gen (
.CLK(CLK16),
.CLKB(CLKB16)
);

endmodule
