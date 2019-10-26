// This module takes the data control clock to determine how frequently to pulse the
// WRT and LDAC functions of the DAC
module ctrl(en,out);
	input en;
	output reg [1:0] out;

	initial begin
		out[1:0] = 2'b11;
	end
	
	
	always @ (posedge en) begin
		out[1:0] <= ~out[1:0];
	end
	
	
endmodule
