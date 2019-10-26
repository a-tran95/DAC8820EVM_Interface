// This module controls what is output to the 7-Segment Displays on the FPGA
module hexcontrol(HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0,fmode,mmode);
	input [2:0] fmode;
	input [1:0] mmode;
	output reg[6:0] HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0;
	
	
	initial begin
		HEX7 = 7'b1111111;
		HEX6 = 7'b1111111;
		HEX5 = 7'b0000110;
		HEX4 = 7'b1111111;
		HEX3 = 7'b0001100;
		HEX2 = 7'b0111111;
		HEX1 = 7'b1111111;
		HEX0 = 7'b1111111;
	end
		
	always @ (fmode) begin
		casex(fmode)
			3'b000:	begin
						HEX6 = 7'b1111001; 
						HEX4 = 7'b0110000;	// 1kHz
						end
						
			3'b001:	begin
						HEX6 = 7'b0010010; 
						HEX4 = 7'b0110000;	// 5kHz
						end
						
			3'b010:	begin
						HEX6 = 7'b1111001; 
						HEX4 = 7'b0011001;	//	10kHz
						end
						
			3'b011: 	begin
						HEX6 = 7'b0010010;
						HEX4 = 7'b0011001;	// 50kHz
						end
						
			3'b100:	begin
						HEX6 = 7'b1111001;
						HEX4 = 7'b0010010; 	// 100kHz
						end
						
			3'b101:	begin
						HEX6 = 7'b0010010;	
						HEX4 = 7'b0010010;   // 500kHz
						end
						
			3'b110:	begin
						HEX6 = 7'b1111001;	
						HEX4 = 7'b0000010; 	//	1MHz
						end
						
			3'b111: 	begin
						HEX6 = 7'b0100100;	
						HEX4 = 7'b0000010;	// 2MHz
						end
						
			default: begin
						HEX6 = 7'bxxxxxxx;
						HEX4 = 7'bxxxxxxx;
						end
		endcase
	end
	
	always @ (mmode) begin
		casex(mmode)
			2'b00:	begin
						HEX1 = 7'b0011001;
						HEX0 = 7'b1111111;	// PAM-4
						end
						
			2'b01:	begin
						HEX1 = 7'b0000000;
						HEX0 = 7'b1111111;	// PAM-8
						end
						
			2'b10:	begin
						HEX1 = 7'b1111001;
						HEX0 = 7'b0000010;	// PAM-16
						end
						
			2'b11:	begin
						HEX1 = 7'b0110000;
						HEX0 = 7'b0100100;	// PAM-32
						end
		endcase
	end

endmodule
