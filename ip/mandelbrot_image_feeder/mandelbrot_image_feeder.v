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

// This core takes a input vector that describes the top left coordinate of a
// Mandelbrot image to be computed along with the image geometry and output
// buffer location.  This core then computes each cluster of pixel workload to
// be passed down to a mandelbrot_coordinate_feeder core for processing and it
// sends that out of its source interface.  This core computes the workloads for
// the entire image defined by the input vector.

module mandelbrot_image_feeder(

	// clock and reset for component
	input  wire        clk,
	input  wire        reset,

	// avst sink interface, in_vector
	// this is a multi-data vector containing:
	//  pix_map_height[15:0] @ snk_data[183:168]
	//   pix_map_width[15:0] @ snk_data[167:152]
	//     pix_buf_ptr[31:0] @ snk_data[151:120]
	//line_count_shift[ 7:0] @ snk_data[119:112]
	//        step_dim[31:0] @ snk_data[111: 80]
	//       max_iters[15:0] @ snk_data[ 79: 64]
	//              cr[31:0] @ snk_data[ 63: 32]
	//              ci[31:0] @ snk_data[ 31: 0]
	input  wire [183:0] in_vector_snk_data,
	input  wire         in_vector_snk_valid,
	output wire         in_vector_snk_ready,

	// avst source interface, out_vector
	// this is a multi-data vector containing:
	// pix_buf_ptr[31:0] @ snk_data[151:120]
	//  line_count[ 7:0] @ snk_data[119:112]
	//    step_dim[31:0] @ snk_data[111: 80]
	//   max_iters[15:0] @ snk_data[ 79: 64]
	//          cr[31:0] @ snk_data[ 63: 32]
	//          ci[31:0] @ snk_data[ 31: 0]
	output wire [151:0] out_vector_src_data,
	output wire         out_vector_src_valid,
	input  wire         out_vector_src_ready
);

localparam STATE_IDLE        = 2'b00;
localparam STATE_FEED_COORDS = 2'b01;
localparam STATE_WAIT_READY  = 2'b10;

wire [31:0] v_ci;
wire [31:0] v_cr;
wire [15:0] v_max_iters;
wire [31:0] v_step_dim;
wire [ 7:0] v_line_count_shift;
wire [31:0] v_pix_buf_ptr;
wire [15:0] v_pix_map_width;
wire [15:0] v_pix_map_height;

reg  [31:0] ci;
reg  [31:0] cr;
reg  [15:0] max_iters;
reg  [31:0] step_dim;
reg  [31:0] multi_step_dim;
reg  [ 7:0] line_count;
reg  [31:0] pix_buf_ptr;
reg  [15:0] pix_map_width;
reg  [15:0] pix_map_height;

reg  [ 1:0] state;
reg  [10:0] pixel_count;
reg  [15:0] cr_x_count;
reg  [15:0] ci_y_count;
reg  [31:0] dma_length;
reg  [31:0] leftmost_cr;

assign {
	v_pix_map_height,
	v_pix_map_width,
	v_pix_buf_ptr,
	v_line_count_shift,
	v_step_dim,
	v_max_iters,
	v_cr,
	v_ci
} = {
	in_vector_snk_data[183:168],
	in_vector_snk_data[167:152],
	in_vector_snk_data[151:120],
	in_vector_snk_data[119:112],
	in_vector_snk_data[111: 80],
	in_vector_snk_data[79:64],
	in_vector_snk_data[63:32],
	in_vector_snk_data[31:0]
};

// in_vector
assign in_vector_snk_ready = (state == STATE_IDLE) ?
				(1'b1) : (1'b0);

// out_vector
assign out_vector_src_valid = (state == STATE_FEED_COORDS) ?
				(1'b1) : (1'b0);

assign out_vector_src_data = {pix_buf_ptr, line_count, step_dim, max_iters, cr, ci};


always @ (posedge clk or posedge reset) begin
if(reset) begin
	ci <= 32'd0;
	cr <= 32'd0;
	max_iters <= 16'd0;
	step_dim <= 32'd0;
	multi_step_dim <= 32'd0;
	line_count <= 8'd0;
	pix_buf_ptr <= 32'd0;
	pix_map_width <= 16'd0;
	pix_map_height <= 16'd0;

	leftmost_cr <= 32'd0;
	pixel_count <= 10'h0;
	cr_x_count <= 16'h0;
	ci_y_count <= 16'h0;
	dma_length <= 32'h0;
	state <= STATE_IDLE;

end else begin

	case(state)
	STATE_IDLE: begin
		ci <= v_ci;
		cr <= v_cr;
		max_iters <= v_max_iters;
		step_dim <= v_step_dim;
		multi_step_dim <= (v_step_dim << v_line_count_shift[2:0]) << 3;
		line_count <= 1'b1 << v_line_count_shift[2:0];
		pix_buf_ptr <= v_pix_buf_ptr;
		pix_map_width <= v_pix_map_width;
		pix_map_height <= v_pix_map_height;

		leftmost_cr <= v_cr;
		pixel_count <= (1'b1 << v_line_count_shift[2:0]) << 3;
		cr_x_count <= 16'h0;
		ci_y_count <= 16'h0;
		dma_length <= (1'b1 << v_line_count_shift[2:0]) << 5;

		if(in_vector_snk_valid & in_vector_snk_ready) begin
			state <= STATE_FEED_COORDS;
		end
	end
	STATE_FEED_COORDS: begin

		if(out_vector_src_valid & out_vector_src_ready) begin

			if((cr_x_count + pixel_count) < pix_map_width) begin
				cr_x_count <= cr_x_count + pixel_count;
				cr <= cr + multi_step_dim;
			end else begin
				if((ci_y_count + 1'b1) < pix_map_height) begin
					ci_y_count <= ci_y_count + 16'd1;
					ci <= ci - step_dim;
					cr_x_count <= 16'd0;
					cr <= leftmost_cr;
				end else begin
					state <= STATE_WAIT_READY;
				end
			end

			pix_buf_ptr <= pix_buf_ptr + dma_length;
		end
	end
	STATE_WAIT_READY: begin

		if(out_vector_src_ready) begin
			state <= STATE_IDLE;
		end
	end
	endcase

end // if
end // always

endmodule

