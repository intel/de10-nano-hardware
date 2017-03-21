/*
 * Copyright (c) 2016 Intel Corporation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */
/* 
This component produces a power on reset strobe.

At power up when the FPGA enters user mode the registers of the
altera_std_synchronizer core will all be set to ZERO.  As the 1'b1 input
propogates through the shift chain of the synchronizer the specified power on
reset delay count will be measured to the number of clocks specified by the
POR_COUNT parameter.

This is intended to create a rather short power on reset delay, between 2 and 32
clocks, so the inefficient use of a shift chain to measure this is not a
significant concern.  The advantage of using the altera_std_synchronizer is that
it takes care of the quartus properties to preserve the registers of the shift
chain and apply the SDC constraints for us.

To constrain the outputs of this component in your own SDC constraints, you can
locate the output registers of the component with something like this:
[get_registers {*power_on_reset:*|output_reg}]

*/
`timescale 1 ps / 1 ps
module power_on_reset #(
	parameter POR_COUNT = 20	// MUST BE 2 or greater
) (
	input  wire  clk,
	output wire  reset
);

wire sync_dout;
altera_std_synchronizer #(
	.depth (POR_COUNT)
) power_on_reset_std_sync_inst (
	.clk     (clk),
	.reset_n (1'b1),
	.din     (1'b1),
	.dout    (sync_dout)
);

reg output_reg;
initial begin
	output_reg <= 1'b0;
end

always @ (posedge clk) begin
	output_reg <= sync_dout;
end

assign reset = ~output_reg;

endmodule

