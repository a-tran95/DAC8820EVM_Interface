// This module constructs the entire sequence, bit by bit
module dataconst(seqin,clk,rst,dataout);
	input seqin, clk, rst;
	output[4:0] dataout;
	reg[4:0] databox;
	
	always @ (posedge clk or negedge rst) begin
		if (~rst)
			databox <= 5'd0;
		else
			databox <= {databox[3:0],seqin};
	end
	
	assign dataout = databox;

endmodule

