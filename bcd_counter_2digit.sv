// bcd_counter_2digit.sv - Two digit BCD counter.  Used in the Scoreboard project  
//
// <your name> (<your email address>)
// <date>
//
// Description:
// ------------
// implements a 2-bit BCD counter for the BCD scoreboard project.  Each digit in a BCD
// counter only counts to 9 (remember the BCD adder from hw2).  When the least significant digit
// overflows (counts > 9) it is cleared and the most significant digit is incremented.  A 2-bit
// BCD counter can count from 00 to 99.
//
// Scoreboard project concept from: "Digital Systems Design in Verilog" by Charles Roth, Lizy
// Kurien John, and Byeong Kil Lee, Cengage Learning, 2016.  Converted to SystemVerilog by Roy Kravitz
//
// This module contains starter code.  You should complete the code according to the specification in
// the homework #2 write-up
//
module bcd_counter_2digit
(
	input	logic			clk,			// input clock
	input	logic			reset, 			// global reset (asserted high to reset)
	input	logic			inc,			// asserted high for 1 cycle to increment the counter
	input	logic			dec,			// asserted high for 1 cycle to decrement the counter
											// counter cannot be decremented below 00
	input	logic			clr,			// asserted high for 1 cycle to clear the counter.
											// This is different than the reset signal which is
											// assumed to be global to the entire circuit
	output	logic	[3:0]	bcd1,			// most significant digit of BCD counter
	output	logic	[3:0]	bcd0			// least significant digit of BCD counter
);

// ADD YOUR CODE HERE

endmodule: bcd_counter_2digit

			

