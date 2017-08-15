//
// Copyright (c) 2017 Intel Corporation
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//

`timescale 1 ps / 1 ps

// This block takes a 32-bit input pixel value that represents the 16-bit value
// of the iteration count discovered by the avst_mandelbrot_engine core and it
// either passes it straight through, or it translates that value into a color
// pixel value from a lookup table and emits that color pixel value.  This core
// looks at the value loaded into its max_iters register to decide if the raw
// data is used or the colorized pixel data.  The max_iters register is a 32-bit
// register loaded via the AVMM slave interface, but only the 16 lsbs are valid.
// If max_iters is set to 0, then the raw input data is passed straight through
// this core, otherwise the colorized data is used.  If colorized data is being
// used, any input value that equals max_iters is encoded as 0x0000_0000 to
// represent a black pixel color.  Black pixels generally represent the value
// of coordinates that reside inside the Mandelbrot set.

module mandelbrot_colorizer(

	// clock and reset for component
	input  wire        clk,
	input  wire        reset,

	// avmm slave interface, sl
	input  wire         sl_read,
	input  wire         sl_write,
	input  wire [  3:0] sl_byteenable,
	input  wire [ 31:0] sl_writedata,
	output wire [ 31:0] sl_readdata,
	output wire         sl_waitrequest,

	// avst sink interface, in_pixel
	input  wire [ 31:0] in_pixel_snk_data,
	input  wire         in_pixel_snk_valid,
	output wire         in_pixel_snk_ready,

	// avst source interface, out_pixel
	output wire [ 31:0] out_pixel_src_data,
	output wire         out_pixel_src_valid,
	input  wire         out_pixel_src_ready
);

wire [15:0] result;
wire        colorize;
wire [31:0] colorized_data;

reg  [15:0] max_iters;
reg  [31:0] color_data;

assign result = {in_pixel_snk_data[23:16], in_pixel_snk_data[31:24]};

assign colorize = |max_iters;

// 16 color table
always @* begin
	// set color data to black, if result == max_iters then it stays black
	color_data <= 32'h00000000;
	if(result != max_iters) begin
		case(result[3:0])
		4'h0: color_data <= 32'h0000CC00;
		4'h1: color_data <= 32'h00CC0000;
		4'h2: color_data <= 32'hCC000000;
		4'h3: color_data <= 32'h9900FF00;
		4'h4: color_data <= 32'h99FF0000;
		4'h5: color_data <= 32'hFF009900;
		4'h6: color_data <= 32'h0099FF00;
		4'h7: color_data <= 32'h00FF9900;
		4'h8: color_data <= 32'hFF990000;
		4'h9: color_data <= 32'h9900CC00;
		4'hA: color_data <= 32'h99CC0000;
		4'hB: color_data <= 32'hCC009900;
		4'hC: color_data <= 32'h0099CC00;
		4'hD: color_data <= 32'h00CC9900;
		4'hE: color_data <= 32'hCC990000;
		4'hF: color_data <= 32'h99009900;
		endcase
	end
end

assign colorized_data = (colorize == 1'b1) ? color_data : in_pixel_snk_data;

altera_avalon_st_pipeline_base
#(
	.BITS_PER_SYMBOL(32)
) st_pipe (
	.clk        (clk),
	.reset      (reset),
	.in_ready   (in_pixel_snk_ready),
	.in_valid   (in_pixel_snk_valid),
	.in_data    (colorized_data),
	.out_ready  (out_pixel_src_ready),
	.out_valid  (out_pixel_src_valid),
	.out_data   (out_pixel_src_data)
);

// avmm slave control

assign sl_readdata = {16'd0, max_iters};
assign sl_waitrequest = 1'b0;

always @ (posedge clk, posedge reset) begin
if(reset) begin
	max_iters <= 16'd0;
end else begin
	if(sl_write & sl_byteenable[0]) begin
		max_iters[7:0] <= sl_writedata[7:0];
	end
	if(sl_write & sl_byteenable[1]) begin
		max_iters[15:8] <= sl_writedata[15:8];
	end
end // if
end // always

endmodule

