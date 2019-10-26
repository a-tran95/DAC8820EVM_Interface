// This module produces a pseudonoise sequence 1 1 1 1 1 0 0 0 1 1 0 1 1 1 0 1 0 1 0 0 0 0 1 0 0 1 0 1 1 0 0
// Uses 5 shift registers
module lfsr_seqL(clk,rst,seqout);
	input clk;
	input rst;
	output seqout;
	reg [4:0] random;
	
	wire feedback = random[4] ^ random[2];		// taps for the XOR-ing

	initial begin
		random <= 5'b11111;							// Start with the seed value
	end
	
	always @ (posedge clk or negedge rst) begin
		if (~rst)
			random <= 5'b11111;
		else
			random <= {random[3:0],feedback};
	end
	
	assign seqout = random[4];
	
endmodule

