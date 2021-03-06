//Verilog HDL for "Stimulator_IMP", "Decoder3_8" "functional"


module Decoder3_8 (
	input [2:0] Bin,
	input Enable,
	output reg[7:0] Dout
);



always@(Bin, Enable) begin
	
	Dout = 8'b00000000;

	if(Enable) begin
		case(Bin)
			3'b000: begin Dout = 8'b00000001; end
			3'b001: begin Dout = 8'b00000010; end
			3'b010: begin Dout = 8'b00000100; end
			3'b011: begin Dout = 8'b00001000; end
			3'b100: begin Dout = 8'b00010000; end
			3'b101: begin Dout = 8'b00100000; end
			3'b110: begin Dout = 8'b01000000; end
			3'b111: begin Dout = 8'b10000000; end
			default: begin Dout = 8'b00000000; end
		endcase
	end
end

endmodule
