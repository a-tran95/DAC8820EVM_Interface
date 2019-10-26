// This module is used to freq. divide the 50 MHz clock to perform different tasks
// Parallel control should be fastest
module clkdiv2(clkin,countin,dout,cout);

	input clkin;
	input [27:0] countin;
	output reg dout,cout;
	reg [27:0] counter1,counter2;

	initial begin
		counter1 = 0;
		counter2 = 25'd25000000;
	end
	
	always @ (posedge clkin) begin
	
		if (counter1 == 0) begin			// Control Clock must have a smaller counter than Data Clock	
			counter1 <= 28'd4;				// starting counter = (50,000,000/Freq)/2 ** Min Value is 4 (6.25MHz) as the DAC's bandwidth is 8MHz.
			cout<= cout + 1'b1;				// Theoretically, to achieve 8MHz, starting counter must be 3.125.
		end										//	Freq for Control Clock must be more than 2 times Data Clock
		else
			counter1 <= counter1 - 1;	
		
		if (counter2 == 0) begin			// Data Clock
			counter2 <= countin;				// starting counter = (50,000,000/Freq)/2 (with f select)
			dout<= dout + 1'b1;					
		end
		else
			counter2 <= counter2 - 1;	
		
	end
	
endmodule
