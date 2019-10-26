module DACtest(GPIO_1,SW,LEDR,LEDG,CLOCK_50,KEY,HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);
	input [4:0] SW;
	input [2:0] KEY;
	input CLOCK_50;
	output [6:0] HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0;
	output [8:0] GPIO_1;
	output [3:0] LEDR;
	output [7:0] LEDG;
	
	wire 	dclk_wire,				//	Data Clock Output
			cclk_wire,				// Data Control Clock Output
			randseq;					//	Next output of PRBS sequence		
	wire [27:0] counter_wire;	// Clock Division Counter
	wire [2:0] fmode_wire;		// Frequency Mode
	wire [1:0] mmode_wire;		// Modulation Mode
	wire [4:0] dataout_wire;	// Contains full 32-level output
	
	assign GPIO_1[8] = SW[1];	// Use SW[4] as the reset switch for the data control
	
	// User Guide //
	// KEY[0] 			- Modulation Select
	// KEY[1] 			- Frequency Select
	// KEY[2] 			- Quick Reset (Outputs 0 for as long as key held)
	// GPIO_1 [1:0] 	- WRT & LDAC Pulse
	//	GPIO_1 [6:2]	- Output
	//	GPIO_1 [7]		- Data Clock
	// SW[1]				- DAC RST control (Pauses DAC output at current state)
	// LEDR [2:0]		- Frequency Mode
	// LEDG [1:0]		- Modulation Mode

	// User-selectable Frequency
	freqselect fsled(.sel(KEY[1]),.mode(LEDG[7:5]),.count(counter_wire[27:0]));
	freqselect fswire(.sel(KEY[1]),.mode(fmode_wire[2:0]));
	
	//	Frequency Dividing Modules controlling Data and Data Control Clocks
	clkdiv2 clkled(.clkin(CLOCK_50),.countin(counter_wire[27:0]),.dout(dclk_wire),.cout(cclk_wire));
	clkdiv2 clkgpio(.clkin(CLOCK_50),.countin(counter_wire[27:0]),.dout(GPIO_1[7]));

	// PRBS Generator Module
	lfsr_seqL rng(.clk(dclk_wire),.rst(KEY[2]),.seqout(randseq));
	dataconst dconst(.seqin(randseq),.clk(dclk_wire),.rst(KEY[1]),.dataout(dataout_wire[4:0]));
	
	// Data Control WRT and LDAC Pulse
	ctrl (.en(cclk_wire),.out(GPIO_1[1:0]));
	
	// User-selectable PAM Level
	modselect msel(.datain(dataout_wire[4:0]),.dataout(GPIO_1[6:2]),.sel(KEY[0]),.clk(dclk_wire),.mode(mmode_wire[1:0]));
	modselect mseled(.datain(dataout_wire[4:0]),.sel(KEY[0]),.clk(dclk_wire),.mode(LEDG[1:0]));
	
	// Hex-Display Module
	hexcontrol (.HEX7(HEX7[6:0]),.HEX6(HEX6[6:0]),.HEX5(HEX5[6:0]),.HEX4(HEX4[6:0]),.HEX3(HEX3[6:0]),
					.HEX2(HEX2[6:0]),.HEX1(HEX1[6:0]),.HEX0(HEX0[6:0]),.fmode(fmode_wire[2:0]),.mmode(mmode_wire[1:0]));

	
endmodule
