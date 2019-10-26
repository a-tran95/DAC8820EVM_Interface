// This module controls the user-interface for selecting frequencies
module freqselect(sel,mode,count);
	input sel;
	output reg [2:0] mode;
	wire[27:0] count_wire;
	output [27:0] count;
	
	initial begin
		mode = 3'd0;							// Initial Frequency is 1kHz															
	end	
	
	always @ (negedge sel) begin
		mode = mode + 1'd1;					// Cycles through each mode
	end
	
	mode2count m2c(.mode(mode[2:0]),.count(count_wire[27:0]));
	assign count = count_wire;
	
endmodule

module mode2count(mode,count);
	input [2:0] mode;
	output reg[27:0] count;
	
	always @ (mode) begin
		casex(mode)
			3'b000:	count = 28'd25000;	// 1kHz
			3'b001:	count = 28'd5000;		// 5kHz
			3'b010:	count = 28'd2500;		//	10kHz
			3'b011: 	count = 28'd500;		// 50kHz
			3'b100:	count = 28'd250;		// 100kHz
			3'b101:	count = 28'd50;		// 500kHz
			3'b110:	count = 28'd25;		//	1MHz
			3'b111: 	count = 28'd12;		// 2MHz
			default: count = 28'd25000;
		endcase
	end
	
endmodule

