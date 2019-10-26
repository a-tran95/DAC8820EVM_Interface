// This module controls the user-interface for selecting PAM levels
module modselect (datain,dataout,sel,clk,mode);
	input sel,clk;
	input [4:0] datain;
	output reg [1:0] mode;
	output reg [4:0] dataout;
	
	initial begin
		mode = 2'd0;												// Initial format is PAM-4
	end	
	
	always @ (negedge sel) begin
		mode <= mode + 1'd1;										// Cycles through each mode
	end
	
	always @ (posedge clk) begin
		casex(mode)
			2'b00:	dataout <= {datain[1:0],3'b0};		// PAM-4  @  Mode = 0
			2'b01:	dataout <= {datain[2:0],2'b0};		// PAM-8  @  Mode = 1
			2'b10:	dataout <= {datain[3:0],1'b0};		// PAM-16 @  Mode = 2
			2'b11:	dataout <= datain;						// PAM-32 @  Mode = 3
			default: dataout <= datain;
		endcase
	end
	
endmodule
