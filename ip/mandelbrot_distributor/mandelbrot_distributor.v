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

// This core is designed to take output vectors from the mandelbrot_image_feeder
// core and distribute them to 1 of 12 possible mandelbrot_coord_feeder cores.
// The core monitors which downstream mandelbrot_coord_feeder cores are ready
// to accept new work and it passes the next input vector down to that core.
//
// There is an AVMM slave interface provided on this core to provide the
// following facilities.  There is an enable register that allows any of the 12
// egress source port to be used, however port 0 can never be disabled.  There
// is a flush control bit that causes this core to consume and discard all input
// vectors presented to the input sink interface.  There is an interrupt enable
// flag that allows the core to signal when it has completed an input frame and
// all downstream processing has completed.  There is an interrupt clear flag
// that can be used to clear any pending interrupt state and there is a flag to
// indicate a pending interrupt.  There are two status registers that allow the
// live and latched state of the downstream source ready ports to be viewed.
//
// See the address map and register defintions for the AVMM slave interface in
// the comments below.

module mandelbrot_distributor(

	// clock and reset for component
	input  wire        clk,
	input  wire        reset,

	// avmm slave interface, sl
	input  wire         sl_read,
	input  wire         sl_write,
	input  wire [  3:0] sl_byteenable,
	input  wire [  2:0] sl_address,
	input  wire [ 31:0] sl_writedata,
	output wire [ 31:0] sl_readdata,
	output wire         sl_waitrequest,
	output wire         sl_readdatavalid,

	// conduit interface, interrupt_out
	output wire         interrupt_out,

	// avst sink interface, out_vector
	// this is a multi-data vector containing:
	// pix_buf_ptr[31:0] @ snk_data[151:120]
	//  line_count[ 7:0] @ snk_data[119:112]
	//    step_dim[31:0] @ snk_data[111: 80]
	//   max_iters[15:0] @ snk_data[ 79: 64]
	//          cr[31:0] @ snk_data[ 63: 32]
	//          ci[31:0] @ snk_data[ 31: 0]
	input  wire [151:0] in_vector_snk_data,
	input  wire         in_vector_snk_valid,
	output reg          in_vector_snk_ready,

	// avst source interface, out_vector_00
	output wire [151:0] out_vector_00_src_data,
	output reg          out_vector_00_src_valid,
	input  wire         out_vector_00_src_ready,

	// avst source interface, out_vector_01
	output wire [151:0] out_vector_01_src_data,
	output reg          out_vector_01_src_valid,
	input  wire         out_vector_01_src_ready,

	// avst source interface, out_vector_02
	output wire [151:0] out_vector_02_src_data,
	output reg          out_vector_02_src_valid,
	input  wire         out_vector_02_src_ready,

	// avst source interface, out_vector_03
	output wire [151:0] out_vector_03_src_data,
	output reg          out_vector_03_src_valid,
	input  wire         out_vector_03_src_ready,

	// avst source interface, out_vector_04
	output wire [151:0] out_vector_04_src_data,
	output reg          out_vector_04_src_valid,
	input  wire         out_vector_04_src_ready,

	// avst source interface, out_vector_05
	output wire [151:0] out_vector_05_src_data,
	output reg          out_vector_05_src_valid,
	input  wire         out_vector_05_src_ready,

	// avst source interface, out_vector_06
	output wire [151:0] out_vector_06_src_data,
	output reg          out_vector_06_src_valid,
	input  wire         out_vector_06_src_ready,

	// avst source interface, out_vector_07
	output wire [151:0] out_vector_07_src_data,
	output reg          out_vector_07_src_valid,
	input  wire         out_vector_07_src_ready,

	// avst source interface, out_vector_08
	output wire [151:0] out_vector_08_src_data,
	output reg          out_vector_08_src_valid,
	input  wire         out_vector_08_src_ready,

	// avst source interface, out_vector_09
	output wire [151:0] out_vector_09_src_data,
	output reg          out_vector_09_src_valid,
	input  wire         out_vector_09_src_ready,

	// avst source interface, out_vector_10
	output wire [151:0] out_vector_10_src_data,
	output reg          out_vector_10_src_valid,
	input  wire         out_vector_10_src_ready,

	// avst source interface, out_vector_11
	output wire [151:0] out_vector_11_src_data,
	output reg          out_vector_11_src_valid,
	input  wire         out_vector_11_src_ready
);

wire [12:0] latch_state;
wire [12:0] port_state;

reg         in_vector_snk_valid_reg;
reg         out_vector_00_src_ready_reg;
reg         out_vector_01_src_ready_reg;
reg         out_vector_02_src_ready_reg;
reg         out_vector_03_src_ready_reg;
reg         out_vector_04_src_ready_reg;
reg         out_vector_05_src_ready_reg;
reg         out_vector_06_src_ready_reg;
reg         out_vector_07_src_ready_reg;
reg         out_vector_08_src_ready_reg;
reg         out_vector_09_src_ready_reg;
reg         out_vector_10_src_ready_reg;
reg         out_vector_11_src_ready_reg;

reg         frame_end;
reg         flush;
reg         int_pending;
reg         int_clear;
reg         int_enable;
reg  [11:0] enable;
reg  [31:0] readdata;
reg         readdatavalid;

assign latch_state = {
	in_vector_snk_valid_reg,
	out_vector_00_src_ready_reg,
	out_vector_01_src_ready_reg,
	out_vector_02_src_ready_reg,
	out_vector_03_src_ready_reg,
	out_vector_04_src_ready_reg,
	out_vector_05_src_ready_reg,
	out_vector_06_src_ready_reg,
	out_vector_07_src_ready_reg,
	out_vector_08_src_ready_reg,
	out_vector_09_src_ready_reg,
	out_vector_10_src_ready_reg,
	out_vector_11_src_ready_reg
};

assign port_state = {
	in_vector_snk_valid,
	out_vector_00_src_ready,
	out_vector_01_src_ready,
	out_vector_02_src_ready,
	out_vector_03_src_ready,
	out_vector_04_src_ready,
	out_vector_05_src_ready,
	out_vector_06_src_ready,
	out_vector_07_src_ready,
	out_vector_08_src_ready,
	out_vector_09_src_ready,
	out_vector_10_src_ready,
	out_vector_11_src_ready
};

assign out_vector_00_src_data = in_vector_snk_data;
assign out_vector_01_src_data = in_vector_snk_data;
assign out_vector_02_src_data = in_vector_snk_data;
assign out_vector_03_src_data = in_vector_snk_data;
assign out_vector_04_src_data = in_vector_snk_data;
assign out_vector_05_src_data = in_vector_snk_data;
assign out_vector_06_src_data = in_vector_snk_data;
assign out_vector_07_src_data = in_vector_snk_data;
assign out_vector_08_src_data = in_vector_snk_data;
assign out_vector_09_src_data = in_vector_snk_data;
assign out_vector_10_src_data = in_vector_snk_data;
assign out_vector_11_src_data = in_vector_snk_data;

always @* begin

in_vector_snk_ready     <= 1'b0;
out_vector_00_src_valid <= 1'b0;
out_vector_01_src_valid <= 1'b0;
out_vector_02_src_valid <= 1'b0;
out_vector_03_src_valid <= 1'b0;
out_vector_04_src_valid <= 1'b0;
out_vector_05_src_valid <= 1'b0;
out_vector_06_src_valid <= 1'b0;
out_vector_07_src_valid <= 1'b0;
out_vector_08_src_valid <= 1'b0;
out_vector_09_src_valid <= 1'b0;
out_vector_10_src_valid <= 1'b0;
out_vector_11_src_valid <= 1'b0;

if(out_vector_00_src_ready & enable[0] & ~flush) begin
	in_vector_snk_ready <= out_vector_00_src_ready;
	out_vector_00_src_valid <= in_vector_snk_valid;
end else if(out_vector_01_src_ready & enable[1] & ~flush) begin
	in_vector_snk_ready <= out_vector_01_src_ready;
	out_vector_01_src_valid <= in_vector_snk_valid;
end else if(out_vector_02_src_ready & enable[2] & ~flush) begin
	in_vector_snk_ready <= out_vector_02_src_ready;
	out_vector_02_src_valid <= in_vector_snk_valid;
end else if(out_vector_03_src_ready & enable[3] & ~flush) begin
	in_vector_snk_ready <= out_vector_03_src_ready;
	out_vector_03_src_valid <= in_vector_snk_valid;
end else if(out_vector_04_src_ready & enable[4] & ~flush) begin
	in_vector_snk_ready <= out_vector_04_src_ready;
	out_vector_04_src_valid <= in_vector_snk_valid;
end else if(out_vector_05_src_ready & enable[5] & ~flush) begin
	in_vector_snk_ready <= out_vector_05_src_ready;
	out_vector_05_src_valid <= in_vector_snk_valid;
end else if(out_vector_06_src_ready & enable[6] & ~flush) begin
	in_vector_snk_ready <= out_vector_06_src_ready;
	out_vector_06_src_valid <= in_vector_snk_valid;
end else if(out_vector_07_src_ready & enable[7] & ~flush) begin
	in_vector_snk_ready <= out_vector_07_src_ready;
	out_vector_07_src_valid <= in_vector_snk_valid;
end else if(out_vector_08_src_ready & enable[8] & ~flush) begin
	in_vector_snk_ready <= out_vector_08_src_ready;
	out_vector_08_src_valid <= in_vector_snk_valid;
end else if(out_vector_09_src_ready & enable[9] & ~flush) begin
	in_vector_snk_ready <= out_vector_09_src_ready;
	out_vector_09_src_valid <= in_vector_snk_valid;
end else if(out_vector_10_src_ready & enable[10] & ~flush) begin
	in_vector_snk_ready <= out_vector_10_src_ready;
	out_vector_10_src_valid <= in_vector_snk_valid;
end else if(out_vector_11_src_ready & enable[11] & ~flush) begin
	in_vector_snk_ready <= out_vector_11_src_ready;
	out_vector_11_src_valid <= in_vector_snk_valid;
end

if(flush) in_vector_snk_ready <= 1'b1;

end // always @*

// avmm slave control and synchronous logic
//
// all registers are allocated as 32-bit registers in the address map but some
// registers are smaller than 32-bits.
//
// latch_state[12:0] @ 6 - 0x18 RO 13-bit register
//  port_state[12:0] @ 5 - 0x14 RO 13-bit register
// int_pending[ 0:0] @ 4 - 0x10 RO 1-bit register
//   int_clear[ 0:0] @ 3 - 0x0C WO 1-bit register
//  int_enable[ 0:0] @ 2 - 0x08 RW 1-bit register
//       flush[ 0:0] @ 1 - 0x04 RW 1-bit register
//      enable[11:0] @ 0 - 0x00 RW 12-bit register

assign sl_readdata = readdata;
assign sl_waitrequest = 1'b0;
assign sl_readdatavalid = readdatavalid;

assign sl_waitrequest = 1'b0;

assign interrupt_out = int_pending & int_enable;

always @ (posedge clk, posedge reset) begin
if(reset) begin

	int_pending <= 1'b0;
	int_clear <= 1'b0;
	int_enable <= 1'b0;
	enable <= 12'd1;
	readdata <= 32'd0;
	readdatavalid <= 1'd0;

	frame_end <= 1'd0;
	flush <= 1'd0;

	in_vector_snk_valid_reg <= 1'd0;
	out_vector_00_src_ready_reg <= 1'd0;
	out_vector_01_src_ready_reg <= 1'd0;
	out_vector_02_src_ready_reg <= 1'd0;
	out_vector_03_src_ready_reg <= 1'd0;
	out_vector_04_src_ready_reg <= 1'd0;
	out_vector_05_src_ready_reg <= 1'd0;
	out_vector_06_src_ready_reg <= 1'd0;
	out_vector_07_src_ready_reg <= 1'd0;
	out_vector_08_src_ready_reg <= 1'd0;
	out_vector_09_src_ready_reg <= 1'd0;
	out_vector_10_src_ready_reg <= 1'd0;
	out_vector_11_src_ready_reg <= 1'd0;

end else begin // if(reset)
	readdatavalid <= 1'b0;
	if(sl_write) begin
		case(sl_address)
		4'h0: begin	// enable
			if(sl_byteenable[0]) enable[ 7:0 ] <= {sl_writedata[ 7:1], 1'b1};
			if(sl_byteenable[1]) enable[11:8 ] <= sl_writedata[11:8];
		end
		4'h1: begin	// flush
			if(sl_byteenable[0]) flush <= sl_writedata[0];
		end
		4'h2: begin	// int_enable
			if(sl_byteenable[0]) int_enable <= sl_writedata[0];
		end
		4'h3: begin	// int_clear
			if(sl_byteenable[0]) int_clear <= sl_writedata[0];
		end
		default:;
		endcase
	end // if(sl_write)

	if(sl_read) begin
		readdatavalid <= 1'b1;
		case(sl_address)
		4'h0: readdata <= {20'd0, enable};
		4'h1: readdata <= {31'd0, flush};
		4'h2: readdata <= {31'd0, int_enable};
		4'h3: readdata <= 32'd0;
		4'h4: readdata <= {31'd0, int_pending};
		4'h5: readdata <= {19'd0, port_state};
		4'h6: readdata <= {19'd0, latch_state};
		default: readdata <= 32'd0;
		endcase
	end // if(sl_read)

	in_vector_snk_valid_reg <= in_vector_snk_valid;

	if(in_vector_snk_valid_reg & ~in_vector_snk_valid) begin
		frame_end <= 1'd1;
	end
	
	if(frame_end) begin
		if(~out_vector_00_src_ready_reg) out_vector_00_src_ready_reg <= out_vector_00_src_ready;
		if(~out_vector_01_src_ready_reg) out_vector_01_src_ready_reg <= out_vector_01_src_ready;
		if(~out_vector_02_src_ready_reg) out_vector_02_src_ready_reg <= out_vector_02_src_ready;
		if(~out_vector_03_src_ready_reg) out_vector_03_src_ready_reg <= out_vector_03_src_ready;
		if(~out_vector_04_src_ready_reg) out_vector_04_src_ready_reg <= out_vector_04_src_ready;
		if(~out_vector_05_src_ready_reg) out_vector_05_src_ready_reg <= out_vector_05_src_ready;
		if(~out_vector_06_src_ready_reg) out_vector_06_src_ready_reg <= out_vector_06_src_ready;
		if(~out_vector_07_src_ready_reg) out_vector_07_src_ready_reg <= out_vector_07_src_ready;
		if(~out_vector_08_src_ready_reg) out_vector_08_src_ready_reg <= out_vector_08_src_ready;
		if(~out_vector_09_src_ready_reg) out_vector_09_src_ready_reg <= out_vector_09_src_ready;
		if(~out_vector_10_src_ready_reg) out_vector_10_src_ready_reg <= out_vector_10_src_ready;
		if(~out_vector_11_src_ready_reg) out_vector_11_src_ready_reg <= out_vector_11_src_ready;
	end

	if(	frame_end &
		out_vector_00_src_ready_reg &
		out_vector_01_src_ready_reg &
		out_vector_02_src_ready_reg &
		out_vector_03_src_ready_reg &
		out_vector_04_src_ready_reg &
		out_vector_05_src_ready_reg &
		out_vector_06_src_ready_reg &
		out_vector_07_src_ready_reg &
		out_vector_08_src_ready_reg &
		out_vector_09_src_ready_reg &
		out_vector_10_src_ready_reg &
		out_vector_11_src_ready_reg) begin

		int_pending <= 1'b1;

		frame_end <= 1'd0;

		out_vector_00_src_ready_reg <= 1'd0;
		out_vector_01_src_ready_reg <= 1'd0;
		out_vector_02_src_ready_reg <= 1'd0;
		out_vector_03_src_ready_reg <= 1'd0;
		out_vector_04_src_ready_reg <= 1'd0;
		out_vector_05_src_ready_reg <= 1'd0;
		out_vector_06_src_ready_reg <= 1'd0;
		out_vector_07_src_ready_reg <= 1'd0;
		out_vector_08_src_ready_reg <= 1'd0;
		out_vector_09_src_ready_reg <= 1'd0;
		out_vector_10_src_ready_reg <= 1'd0;
		out_vector_11_src_ready_reg <= 1'd0;
	end


	if(int_clear) begin
		int_clear <= 1'b0;
		int_pending <= 1'b0;
	end

end // else
end // always

endmodule

