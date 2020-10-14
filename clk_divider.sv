// clk_divider.sv - parameterized clock divider
//
// Roy Kravitz
// 09-Oct-2020
//
// Description:
// ------------
// Implements a clock divider that can be used to generate a slow(er) clock from the system clock.
// The module is parameterized so that the clock divider can generate a range of clock outputs.
// The output clock "tick" is single cycle pulse so that it is usable as an enable in clocked sequential
// logic.
//
// Original code by Roy Kravitz.  Converted to SystemVerilog by Roy Kravitz, 2020
module clk_divider
#(
	parameter	CLK_INPUT_FREQ_HZ = 32'd100_000_000,	// clock input frequencey in HZ,
														// defaults to 100MHz
	parameter	TICK_OUT_FREQ_HZ = 32'd100_000,			// clock output frequency in HZ,
														// defaults to 100KHz
	parameter	SIMULATE = 0							// simulation or hardware, default to hardware
														// if SIMULATE is asserted the clock timeout 
														// period is shortened
)
(
	input logic		clk,			// input clock
	input logic		reset,			// reset signal, asserted high to reset the circuit
	output logic	tick_out		// output clock pulse.  1 cycle pulse at output frequency
);

// local parameters to calculate divider counter parameters
// Top count for clock counter is Input Freq/Output Frequency. For example, using
// the default case  CLK_COUNT is 1000
localparam	[31:0]		CLK_COUNTS = CLK_INPUT_FREQ_HZ / TICK_OUT_FREQ_HZ;	

// top count for clock divider counter. Subtract 1 from the count because
// the timer starts at 0																				
localparam	[31:0]		clk_top_count = SIMULATE ? 32'd5 : (CLK_COUNTS - 1);

// internal variables
logic	[31:0]			clk_div_counter;	// clock divider


// implement the clock divider. Use a synchronous reset because Cumming/Mills recommend
// it as a way to avoid issues when the circuit comes out of reset
always_ff @(posedge clk) begin: divider_counter
	if (reset)  begin
		clk_div_counter <= '0;
		tick_out <= 1'b0;
	end
	else if (clk_div_counter == clk_top_count) begin
		clk_div_counter <= '0;
		tick_out <= 1'b1;
	end
	else begin
		clk_div_counter <= clk_div_counter + 1;
		tick_out <= 1'b0;
	end
end: divider_counter

endmodule: clk_divider
