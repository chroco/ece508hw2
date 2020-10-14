// input_logic.sv - input logic for BCD scoreboard project
//
// Roy Kravitz
// 09-Oct-2020
//
// Description:
// ------------
// implements input conditioning logic for the BCD scoreboard project.  Synchronizes the input
// "buttons" and debounces them.  Conditions a button press so that it only lasts for a single
// cycle.  This type of input is good when using the signal as an enable for a clocked synchronous
// circuit.  This version supports pushbutton input from 3 buttons (btnA, btnB, and btnC)
//
// Scoreboard project concept from: "Digital Systems Design in Verilog" by Charles Roth, Lizy
// Kurien John, and Byeong Kil Lee, Cengage Learning, 2016.  Converted to SystemVerilog by Roy Kravitz.
//
module input_logic
(
	input logic		btnA_in, btnB_in, btnC_in,		// button inputs
	input logic		clk, reset,						// clock and reset (reset asserted high)
	output logic	btnA_out, btnB_out, btnC_out	// synchronized, conditioned button outputs
);

// internal variables
logic	btnA_sync, btnA_d, btnA_dd;		// synchronizing and conditioning flip-flops for btnA
logic	btnB_sync, btnB_d, btnB_dd;		// synchronizing and conditioning flip-flops for btnB
logic	btnC_sync, btnC_d, btnC_dd;		// synchronizing and conditioning flip-flops for btnC


always_ff @(posedge clk or posedge reset) begin: synchronizers
	if (reset) begin
		{btnA_sync, btnA_d} <= 2'b00;
		{btnB_sync, btnB_d} <= 2'b00;
		{btnC_sync, btnC_d} <= 2'b00;
	end
	else begin
		{btnA_sync, btnA_d} <= {btnA_d, btnA_in};
		{btnB_sync, btnB_d} <= {btnB_d, btnB_in};		
		{btnC_sync, btnC_d} <= {btnC_d, btnC_in};
	end
end: synchronizers

// flip-flops to delay the synchronized button
// the complemented delayed button press is compared to the current button
// press by the assign statements to limit the pulse to one clock cycle
always_ff @(posedge clk or posedge reset) begin: conditioning_flip_flops
	if (reset) begin
		btnA_dd <= 1'b0;
		btnB_dd <= 1'b0;
		btnC_dd <= 1'b0;
	end
	else begin
		btnA_dd <= btnA_sync;
		btnB_dd <= btnB_sync;
		btnC_dd <= btnC_sync;
	end
end: conditioning_flip_flops

// limit the button press to a single clock cycle
always_comb begin: conditioners
	btnA_out = btnA_sync & ~btnA_dd;
	btnB_out = btnB_sync & ~btnB_dd;
	btnC_out = btnC_sync & ~btnC_dd;
end: conditioners

endmodule: input_logic