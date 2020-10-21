// sseg_encoder.sv - 7-segment display encoder for BCD digits
//
// <your name>  (<your email address)
// <date>
//
// Description:
// ------------
// implements a 7-segment encoder for the digits 0 - 9.  Converts a 4-bit BCD number to a 7-bit
// encoding (1 bit per segment of the display).  Assumes that a segment is lit by driving a 1
// to it.  Uses a Verilog array configured as a ROM to do the encoding.
//
// Scoreboard project concept from: "Digital Systems Design in Verilog" by Charles Roth, Lizy
// Kurien John, and Byeong Kil Lee, Cengage Learning, 2016. Converted to SystemVerilog by Roy Kravitz
//
// This module need to be completed by you starting with // ADD YOUR CODE HERE

module sseg_encoder
#(
	parameter	SEG_POLARITY = 1    // Set the bit value for lighting a segment
                                // SEG_POLARITY =1 says light the segment by
                                // driving a 1 to it.  SEG_POLARITY = 0 says
                                // light a segment by driving a 0 to it
                                // default value is 1 to light.
)
(
	input logic		[3:0]	bcd_in,		// BCD input value
	output logic	[6:0]	sseg_out	// 7-segment encoded value
);

logic [3:0][6:0] bcdlut;

initial begin
  bcdlut[4'b0000] = 7'b0111111;
  bcdlut[4'b0001] = 7'b0000110;
  bcdlut[4'b0010] = 7'b1011011;
  bcdlut[4'b0011] = 7'b1001111;
  bcdlut[4'b0100] = 7'b1100110;
  bcdlut[4'b0101] = 7'b1101101;
  bcdlut[4'b0110] = 7'b1111100;
  bcdlut[4'b0111] = 7'b0000111;
  bcdlut[4'b1000] = 7'b1111111;
  bcdlut[4'b1001] = 7'b1100111;
  bcdlut[4'b1010] = 7'b1111001;
  bcdlut[4'b1011] = 7'b1111001;
  bcdlut[4'b1100] = 7'b1111001;
  bcdlut[4'b1101] = 7'b1111001;
  bcdlut[4'b1110] = 7'b1111001;
  bcdlut[4'b1111] = 7'b1111001;
end

assign sseg_out[6:0] = bcdlut[bcd_in[3:0]];

endmodule: sseg_encoder

