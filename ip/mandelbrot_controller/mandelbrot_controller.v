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

// This core provides an AVMM slave interface to store the values required to
// form an input vector to the mandelbrot_image_feeder core along with a go bit
// to send the input vector and a status register that can monitor the read bits
// on the AVST output pipeline stage.
//
// See the address map and register bit definitions in the comments below.

module mandelbrot_controller(

	// clock and reset for component
	input  wire        clk,
	input  wire        reset,

	// avmm slave interface, sl
	input  wire         sl_read,
	input  wire         sl_write,
	input  wire [  3:0] sl_byteenable,
	input  wire [  3:0] sl_address,
	input  wire [ 31:0] sl_writedata,
	output wire [ 31:0] sl_readdata,
	output wire         sl_waitrequest,
	output wire         sl_readdatavalid,

	// avst source interface, out_vector
	// this is a multi-data vector containing:
	//  pix_map_height[15:0] @ src_data[183:168]
	//   pix_map_width[15:0] @ src_data[167:152]
	//     pix_buf_ptr[31:0] @ src_data[151:120]
	//line_count_shift[ 7:0] @ src_data[119:112]
	//        step_dim[31:0] @ src_data[111: 80]
	//       max_iters[15:0] @ src_data[ 79: 64]
	//              cr[31:0] @ src_data[ 63: 32]
	//              ci[31:0] @ src_data[ 31: 0]
	output wire [183:0] out_vector_src_data,
	output wire         out_vector_src_valid,
	input  wire         out_vector_src_ready
);

wire         ready_i;
wire         ready_o;
wire [183:0] in_vector;

reg  [ 15:0] pix_map_height;
reg  [ 15:0] pix_map_width;
reg  [ 31:0] pix_buf_ptr;
reg  [  7:0] line_count_shift;
reg  [ 31:0] step_dim;
reg  [ 15:0] max_iters;
reg  [ 31:0] cr;
reg  [ 31:0] ci;

reg          go;
reg  [ 31:0] readdata;
reg          readdatavalid;

assign in_vector = {
	pix_map_height,
	pix_map_width,
	pix_buf_ptr,
	line_count_shift,
	step_dim,
	max_iters,
	cr,
	ci
};

assign ready_o = out_vector_src_ready;

altera_avalon_st_pipeline_base
#(
	.BITS_PER_SYMBOL(184)
) st_pipe (
	.clk        (clk),
	.reset      (reset),
	.in_ready   (ready_i),
	.in_valid   (go),
	.in_data    (in_vector),
	.out_ready  (ready_o),
	.out_valid  (out_vector_src_valid),
	.out_data   (out_vector_src_data)
);

// avmm slave control
//
// all registers are allocated as 32-bit registers in the address map but some
// registers are smaller than 32-bits.
//
//           status[ 1:0] @ 0x09 3-bit register {ready_i, ready_o, go}
//          control[ 0:0] @ 0x08 1-bit register {go}
//   pix_map_height[15:0] @ 0x07 16-bit register
//    pix_map_width[15:0] @ 0x06 16-bit register
//      pix_buf_ptr[31:0] @ 0x05 32-bit register
// line_count_shift[ 7:0] @ 0x04 8-bit register only 3 lsb are valid
//         step_dim[31:0] @ 0x03 32-bit register
//        max_iters[15:0] @ 0x02 16-bit register
//               cr[31:0] @ 0x01 32-bit register
//               ci[31:0] @ 0x00 32-bit register

assign sl_readdata = readdata;
assign sl_waitrequest = 1'b0;
assign sl_readdatavalid = readdatavalid;

assign sl_waitrequest = 1'b0;

always @ (posedge clk, posedge reset) begin
if(reset) begin
	pix_map_height <= 16'd0;
	pix_map_width <= 16'd0;
	pix_buf_ptr <= 32'd0;
	line_count_shift <= 8'd0;
	step_dim <= 32'd0;
	max_iters <= 16'd0;
	cr <= 32'd0;
	ci <= 32'd0;

	go <= 1'd0;
	readdata <= 32'd0;
	readdatavalid <= 1'd0;

end else begin // if(reset)
	readdatavalid <= 1'b0;
	if(sl_write) begin
		case(sl_address)
		4'h0: begin	// ci
			if(sl_byteenable[0]) ci[ 7:0 ] <= sl_writedata[ 7:0 ];
			if(sl_byteenable[1]) ci[15:8 ] <= sl_writedata[15:8 ];
			if(sl_byteenable[2]) ci[23:16] <= sl_writedata[23:16];
			if(sl_byteenable[3]) ci[31:24] <= sl_writedata[31:24];
		end
		4'h1: begin	// cr
			if(sl_byteenable[0]) cr[ 7:0 ] <= sl_writedata[ 7:0 ];
			if(sl_byteenable[1]) cr[15:8 ] <= sl_writedata[15:8 ];
			if(sl_byteenable[2]) cr[23:16] <= sl_writedata[23:16];
			if(sl_byteenable[3]) cr[31:24] <= sl_writedata[31:24];
		end
		4'h2: begin	// max_iters
			if(sl_byteenable[0]) max_iters[ 7:0 ] <= sl_writedata[ 7:0 ];
			if(sl_byteenable[1]) max_iters[15:8 ] <= sl_writedata[15:8 ];
		end
		4'h3: begin	// step_dim
			if(sl_byteenable[0]) step_dim[ 7:0 ] <= sl_writedata[ 7:0 ];
			if(sl_byteenable[1]) step_dim[15:8 ] <= sl_writedata[15:8 ];
			if(sl_byteenable[2]) step_dim[23:16] <= sl_writedata[23:16];
			if(sl_byteenable[3]) step_dim[31:24] <= sl_writedata[31:24];
		end
		4'h4: begin	// line_count_shift
			if(sl_byteenable[0]) line_count_shift[ 7:0 ] <= {5'd0, sl_writedata[ 2:0 ]};
		end
		4'h5: begin	// pix_buf_ptr
			if(sl_byteenable[0]) pix_buf_ptr[ 7:0 ] <= sl_writedata[ 7:0 ];
			if(sl_byteenable[1]) pix_buf_ptr[15:8 ] <= sl_writedata[15:8 ];
			if(sl_byteenable[2]) pix_buf_ptr[23:16] <= sl_writedata[23:16];
			if(sl_byteenable[3]) pix_buf_ptr[31:24] <= sl_writedata[31:24];
		end
		4'h6: begin	// pix_map_width
			if(sl_byteenable[0]) pix_map_width[ 7:0 ] <= sl_writedata[ 7:0 ];
			if(sl_byteenable[1]) pix_map_width[15:8 ] <= sl_writedata[15:8 ];
		end
		4'h7: begin	// pix_map_height
			if(sl_byteenable[0]) pix_map_height[ 7:0 ] <= sl_writedata[ 7:0 ];
			if(sl_byteenable[1]) pix_map_height[15:8 ] <= sl_writedata[15:8 ];
		end
		4'h8: begin	// control
			if(sl_byteenable[0]) go <= sl_writedata[0];
		end
		default:;
		endcase
	end // if(sl_write)

	if(sl_read) begin
		readdatavalid <= 1'b1;
		case(sl_address)
		4'h0: readdata <= ci[31:0];
		4'h1: readdata <= cr[31:0];
		4'h2: readdata <= {16'd0, max_iters[15:0]};
		4'h3: readdata <= step_dim[31:0];
		4'h4: readdata <= {24'd0, line_count_shift[7:0]};
		4'h5: readdata <= pix_buf_ptr[31:0];
		4'h6: readdata <= {16'd0, pix_map_width[15:0]};
		4'h7: readdata <= {16'd0, pix_map_height[15:0]};
		4'h8: readdata <= {31'd0, go};
		4'h9: readdata <= {29'd0, ready_i, ready_o, go};
		default: readdata <= 32'd0;
		endcase
	end // if(sl_read)

	if(go) begin
		if(ready_i) go <= 1'b0;
	end // if(go)
end // else
end // always

endmodule

