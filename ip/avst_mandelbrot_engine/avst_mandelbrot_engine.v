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

// This core calculates the number of iterations required to determine that the
// input coordinate falls within the Mandelbrot set.  If it reaches the maximum
// iteration count before finding the coordinate within the set, then it returns
// the maximum iteration count, otherwise it returns the iteration count
// required to find the coordinate within the set.
//
// The input vector consists of the cr, and ci values along with the max_iters
// value for the maximum iteration count.  The cr and ci values are encoded as
// fixed point signed integers where the upper 4-bits contain the signed integer
// portion of the number and the lower 28-bits contain the fractional portion of
// the number.

module avst_mandelbrot_engine(

	// clock and reset for component
	input  wire        clk,
	input  wire        reset,

	// avst sink interface, in_vector
	// this is a multi-data vector containing:
	// max_iters[15:0] @ snk_data[79:64]
	//        cr[31:0] @ snk_data[63:32]
	//        ci[31:0] @ snk_data[31:0]
	input  wire [79:0] snk_data,
	input  wire        snk_valid,
	output wire        snk_ready,

	// avst source interface, out_result
	output wire [15:0] src_data,
	output wire        src_valid,
	input  wire        src_ready
);

wire        capture_next_task;
wire        keep_processing;
wire [31:0] v_ci;
wire [31:0] v_cr;
wire [15:0] v_max_iters;

wire [63:0] xx_plus_yy;
wire [63:0] xx_minus_yy;
wire [63:0] xx;
wire [63:0] yy;
wire [63:0] xy;

reg  [31:0] ci;
reg  [31:0] cr;
reg  [15:0] max_iters;
reg  [15:0] cur_iters;
reg  [31:0] x;
reg  [31:0] y;
reg         busy;
reg         done;

assign snk_ready = ~busy & ~done;

assign src_valid = done;

assign src_data = cur_iters;

assign capture_next_task = snk_valid & snk_ready;

assign keep_processing = ((xx_plus_yy[63:56] < 8'h04) &
				((cur_iters + 1) < max_iters)) ?
					1'b1 : 1'b0;

assign {v_max_iters, v_cr, v_ci} = snk_data;

always @ (posedge clk or posedge reset) begin
if(reset) begin
	ci <= 32'd0;
	cr <= 32'd0;
	max_iters <= 16'd0;
	cur_iters <= 16'd0;
	x <= 32'd0;
	y <= 32'd0;
	busy <= 1'b0;
	done <= 1'b0;

end else begin

	if(capture_next_task) begin
		ci <= v_ci;
		cr <= v_cr;
		max_iters <= v_max_iters;
		cur_iters <= 16'd0;
		x <= 32'd0;
		y <= 32'd0;
		busy <= 1'b1;

	end else if(busy) begin

		// x gets ((xx) - (yy)) + cr) and starts with 0x0
		x <= xx_minus_yy[59:28] + cr;

		// y gets (2*x*y) + ci) and starts with 0x0
		y <= xy[58:27] + ci;

		// increment for each iteration
		cur_iters <= cur_iters + 16'd1;

		// remain busy until ((xx) + (yy)) > 4 or we execeed max_iters
		busy <= keep_processing;

		done <= ~keep_processing;

	end else if(done) begin

		done <= ~src_ready;
	end
end // if
end // always

// continuously compute ((xx) + (yy)) and ((xx) - (yy))
assign xx_plus_yy = xx + yy;
assign xx_minus_yy = xx - yy;

// multiplications for xx, yy and xy
mandelbrot_altera_mult_add xx_inst(
	.result	 (xx),
	.dataa (x),
	.datab (x)
);

mandelbrot_altera_mult_add yy_inst(
	.result	 (yy),
	.dataa (y),
	.datab (y)
);

mandelbrot_altera_mult_add xy_inst(
	.result	 (xy),
	.dataa (x),
	.datab (y)
);

endmodule

// define a module for the altera_mult_add core
module mandelbrot_altera_mult_add (
		output wire [63:0] result,
		input  wire [31:0] dataa,
		input  wire [31:0] datab
	);

altera_mult_add altera_mult_add_component (
	.dataa (dataa),
	.datab (datab),
	.result (result),
	.accum_sload (1'b0),
	.aclr0 (1'b0),
	.aclr1 (1'b0),
	.aclr2 (1'b0),
	.aclr3 (1'b0),
	.addnsub1 (1'b1),
	.addnsub1_round (1'b0),
	.addnsub3 (1'b1),
	.addnsub3_round (1'b0),
	.chainin (1'b0),
	.chainout_round (1'b0),
	.chainout_sat_overflow (),
	.chainout_saturate (1'b0),
	.clock0 (1'b1),
	.clock1 (1'b1),
	.clock2 (1'b1),
	.clock3 (1'b1),
	.coefsel0 ({3{1'b0}}),
	.coefsel1 ({3{1'b0}}),
	.coefsel2 ({3{1'b0}}),
	.coefsel3 ({3{1'b0}}),
	.datac ({16{1'b0}}),
	.ena0 (1'b1),
	.ena1 (1'b1),
	.ena2 (1'b1),
	.ena3 (1'b1),
	.mult01_round (1'b0),
	.mult01_saturation (1'b0),
	.mult0_is_saturated (),
	.mult1_is_saturated (),
	.mult23_round (1'b0),
	.mult23_saturation (1'b0),
	.mult2_is_saturated (),
	.mult3_is_saturated (),
	.negate (1'b0),
	.output_round (1'b0),
	.output_saturate (1'b0),
	.overflow (),
	.rotate (1'b0),
	.scanina ({32{1'b0}}),
	.scaninb ({32{1'b0}}),
	.scanouta (),
	.scanoutb (),
	.sclr0 (1'b0),
	.sclr1 (1'b0),
	.sclr2 (1'b0),
	.sclr3 (1'b0),
	.shift_right (1'b0),
	.signa (1'b0),
	.signb (1'b0),
	.sload_accum (1'b0),
	.sourcea ({1{1'b0}}),
	.sourceb ({1{1'b0}}),
	.zero_chainout (1'b0),
	.zero_loopback (1'b0)
);
defparam
	altera_mult_add_component.number_of_multipliers = 1,
	altera_mult_add_component.width_a = 32,
	altera_mult_add_component.width_b = 32,
	altera_mult_add_component.width_result = 64,
	altera_mult_add_component.output_register = "UNREGISTERED",
	altera_mult_add_component.output_aclr = "NONE",
	altera_mult_add_component.output_sclr = "NONE",
	altera_mult_add_component.multiplier1_direction = "ADD",
	altera_mult_add_component.port_addnsub1 = "PORT_UNUSED",
	altera_mult_add_component.addnsub_multiplier_register1 = "UNREGISTERED",
	altera_mult_add_component.addnsub_multiplier_aclr1 = "NONE",
	altera_mult_add_component.addnsub_multiplier_sclr1 = "NONE",
	altera_mult_add_component.multiplier3_direction = "ADD",
	altera_mult_add_component.port_addnsub3 = "PORT_UNUSED",
	altera_mult_add_component.addnsub_multiplier_register3 = "UNREGISTERED",
	altera_mult_add_component.addnsub_multiplier_aclr3 = "NONE",
	altera_mult_add_component.addnsub_multiplier_sclr3 = "NONE",
	altera_mult_add_component.use_subnadd = "NO",
	altera_mult_add_component.representation_a = "SIGNED",
	altera_mult_add_component.port_signa = "PORT_UNUSED",
	altera_mult_add_component.signed_register_a = "UNREGISTERED",
	altera_mult_add_component.signed_aclr_a = "NONE",
	altera_mult_add_component.signed_sclr_a = "NONE",
	altera_mult_add_component.port_signb = "PORT_UNUSED",
	altera_mult_add_component.representation_b = "SIGNED",
	altera_mult_add_component.signed_register_b = "UNREGISTERED",
	altera_mult_add_component.signed_aclr_b = "NONE",
	altera_mult_add_component.signed_sclr_b = "NONE",
	altera_mult_add_component.input_register_a0 = "UNREGISTERED",
	altera_mult_add_component.input_register_a1 = "UNREGISTERED",
	altera_mult_add_component.input_register_a2 = "UNREGISTERED",
	altera_mult_add_component.input_register_a3 = "UNREGISTERED",
	altera_mult_add_component.input_aclr_a0 = "NONE",
	altera_mult_add_component.input_aclr_a1 = "NONE",
	altera_mult_add_component.input_aclr_a2 = "NONE",
	altera_mult_add_component.input_aclr_a3 = "NONE",
	altera_mult_add_component.input_sclr_a0 = "NONE",
	altera_mult_add_component.input_sclr_a1 = "NONE",
	altera_mult_add_component.input_sclr_a2 = "NONE",
	altera_mult_add_component.input_sclr_a3 = "NONE",
	altera_mult_add_component.input_register_b0 = "UNREGISTERED",
	altera_mult_add_component.input_register_b1 = "UNREGISTERED",
	altera_mult_add_component.input_register_b2 = "UNREGISTERED",
	altera_mult_add_component.input_register_b3 = "UNREGISTERED",
	altera_mult_add_component.input_aclr_b0 = "NONE",
	altera_mult_add_component.input_aclr_b1 = "NONE",
	altera_mult_add_component.input_aclr_b2 = "NONE",
	altera_mult_add_component.input_aclr_b3 = "NONE",
	altera_mult_add_component.input_sclr_b0 = "NONE",
	altera_mult_add_component.input_sclr_b1 = "NONE",
	altera_mult_add_component.input_sclr_b2 = "NONE",
	altera_mult_add_component.input_sclr_b3 = "NONE",
	altera_mult_add_component.scanouta_register = "UNREGISTERED",
	altera_mult_add_component.scanouta_aclr = "NONE",
	altera_mult_add_component.scanouta_sclr = "NONE",
	altera_mult_add_component.input_source_a0 = "DATAA",
	altera_mult_add_component.input_source_a1 = "DATAA",
	altera_mult_add_component.input_source_a2 = "DATAA",
	altera_mult_add_component.input_source_a3 = "DATAA",
	altera_mult_add_component.input_source_b0 = "DATAB",
	altera_mult_add_component.input_source_b1 = "DATAB",
	altera_mult_add_component.input_source_b2 = "DATAB",
	altera_mult_add_component.input_source_b3 = "DATAB",
	altera_mult_add_component.multiplier_register0 = "UNREGISTERED",
	altera_mult_add_component.multiplier_register1 = "UNREGISTERED",
	altera_mult_add_component.multiplier_register2 = "UNREGISTERED",
	altera_mult_add_component.multiplier_register3 = "UNREGISTERED",
	altera_mult_add_component.multiplier_aclr0 = "NONE",
	altera_mult_add_component.multiplier_aclr1 = "NONE",
	altera_mult_add_component.multiplier_aclr2 = "NONE",
	altera_mult_add_component.multiplier_aclr3 = "NONE",
	altera_mult_add_component.multiplier_sclr0 = "NONE",
	altera_mult_add_component.multiplier_sclr1 = "NONE",
	altera_mult_add_component.multiplier_sclr2 = "NONE",
	altera_mult_add_component.multiplier_sclr3 = "NONE",
	altera_mult_add_component.preadder_mode = "SIMPLE",
	altera_mult_add_component.preadder_direction_0 = "ADD",
	altera_mult_add_component.preadder_direction_1 = "ADD",
	altera_mult_add_component.preadder_direction_2 = "ADD",
	altera_mult_add_component.preadder_direction_3 = "ADD",
	altera_mult_add_component.width_c = 16,
	altera_mult_add_component.input_register_c0 = "UNREGISTERED",
	altera_mult_add_component.input_register_c1 = "UNREGISTERED",
	altera_mult_add_component.input_register_c2 = "UNREGISTERED",
	altera_mult_add_component.input_register_c3 = "UNREGISTERED",
	altera_mult_add_component.input_aclr_c0 = "NONE",
	altera_mult_add_component.input_aclr_c1 = "NONE",
	altera_mult_add_component.input_aclr_c2 = "NONE",
	altera_mult_add_component.input_aclr_c3 = "NONE",
	altera_mult_add_component.input_sclr_c0 = "NONE",
	altera_mult_add_component.input_sclr_c1 = "NONE",
	altera_mult_add_component.input_sclr_c2 = "NONE",
	altera_mult_add_component.input_sclr_c3 = "NONE",
	altera_mult_add_component.width_coef = 18,
	altera_mult_add_component.coefsel0_register = "UNREGISTERED",
	altera_mult_add_component.coefsel1_register = "UNREGISTERED",
	altera_mult_add_component.coefsel2_register = "UNREGISTERED",
	altera_mult_add_component.coefsel3_register = "UNREGISTERED",
	altera_mult_add_component.coefsel0_aclr = "NONE",
	altera_mult_add_component.coefsel1_aclr = "NONE",
	altera_mult_add_component.coefsel2_aclr = "NONE",
	altera_mult_add_component.coefsel3_aclr = "NONE",
	altera_mult_add_component.coefsel0_sclr = "NONE",
	altera_mult_add_component.coefsel1_sclr = "NONE",
	altera_mult_add_component.coefsel2_sclr = "NONE",
	altera_mult_add_component.coefsel3_sclr = "NONE",
	altera_mult_add_component.coef0_0 = 0,
	altera_mult_add_component.coef0_1 = 0,
	altera_mult_add_component.coef0_2 = 0,
	altera_mult_add_component.coef0_3 = 0,
	altera_mult_add_component.coef0_4 = 0,
	altera_mult_add_component.coef0_5 = 0,
	altera_mult_add_component.coef0_6 = 0,
	altera_mult_add_component.coef0_7 = 0,
	altera_mult_add_component.coef1_0 = 0,
	altera_mult_add_component.coef1_1 = 0,
	altera_mult_add_component.coef1_2 = 0,
	altera_mult_add_component.coef1_3 = 0,
	altera_mult_add_component.coef1_4 = 0,
	altera_mult_add_component.coef1_5 = 0,
	altera_mult_add_component.coef1_6 = 0,
	altera_mult_add_component.coef1_7 = 0,
	altera_mult_add_component.coef2_0 = 0,
	altera_mult_add_component.coef2_1 = 0,
	altera_mult_add_component.coef2_2 = 0,
	altera_mult_add_component.coef2_3 = 0,
	altera_mult_add_component.coef2_4 = 0,
	altera_mult_add_component.coef2_5 = 0,
	altera_mult_add_component.coef2_6 = 0,
	altera_mult_add_component.coef2_7 = 0,
	altera_mult_add_component.coef3_0 = 0,
	altera_mult_add_component.coef3_1 = 0,
	altera_mult_add_component.coef3_2 = 0,
	altera_mult_add_component.coef3_3 = 0,
	altera_mult_add_component.coef3_4 = 0,
	altera_mult_add_component.coef3_5 = 0,
	altera_mult_add_component.coef3_6 = 0,
	altera_mult_add_component.coef3_7 = 0,
	altera_mult_add_component.accumulator = "NO",
	altera_mult_add_component.accum_direction = "ADD",
	altera_mult_add_component.use_sload_accum_port = "NO",
	altera_mult_add_component.loadconst_value = 64,
	altera_mult_add_component.accum_sload_register = "UNREGISTERED",
	altera_mult_add_component.accum_sload_aclr = "NONE",
	altera_mult_add_component.accum_sload_sclr = "NONE",
	altera_mult_add_component.double_accum = "NO",
	altera_mult_add_component.width_chainin = 1,
	altera_mult_add_component.chainout_adder = "NO",
	altera_mult_add_component.chainout_adder_direction = "ADD",
	altera_mult_add_component.port_negate = "PORT_UNUSED",
	altera_mult_add_component.negate_register = "UNREGISTERED",
	altera_mult_add_component.negate_aclr = "NONE",
	altera_mult_add_component.negate_sclr = "NONE",
	altera_mult_add_component.systolic_delay1 = "UNREGISTERED",
	altera_mult_add_component.systolic_aclr1 = "NONE",
	altera_mult_add_component.systolic_sclr1 = "NONE",
	altera_mult_add_component.systolic_delay3 = "UNREGISTERED",
	altera_mult_add_component.systolic_aclr3 = "NONE",
	altera_mult_add_component.systolic_sclr3 = "NONE",
	altera_mult_add_component.latency = 0,
	altera_mult_add_component.input_a0_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_a1_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_a2_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_a3_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_a0_latency_aclr = "NONE",
	altera_mult_add_component.input_a1_latency_aclr = "NONE",
	altera_mult_add_component.input_a2_latency_aclr = "NONE",
	altera_mult_add_component.input_a3_latency_aclr = "NONE",
	altera_mult_add_component.input_a0_latency_sclr = "NONE",
	altera_mult_add_component.input_a1_latency_sclr = "NONE",
	altera_mult_add_component.input_a2_latency_sclr = "NONE",
	altera_mult_add_component.input_a3_latency_sclr = "NONE",
	altera_mult_add_component.input_b0_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_b1_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_b2_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_b3_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_b0_latency_aclr = "NONE",
	altera_mult_add_component.input_b1_latency_aclr = "NONE",
	altera_mult_add_component.input_b2_latency_aclr = "NONE",
	altera_mult_add_component.input_b3_latency_aclr = "NONE",
	altera_mult_add_component.input_b0_latency_sclr = "NONE",
	altera_mult_add_component.input_b1_latency_sclr = "NONE",
	altera_mult_add_component.input_b2_latency_sclr = "NONE",
	altera_mult_add_component.input_b3_latency_sclr = "NONE",
	altera_mult_add_component.input_c0_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_c1_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_c2_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_c3_latency_clock = "UNREGISTERED",
	altera_mult_add_component.input_c0_latency_aclr = "NONE",
	altera_mult_add_component.input_c1_latency_aclr = "NONE",
	altera_mult_add_component.input_c2_latency_aclr = "NONE",
	altera_mult_add_component.input_c3_latency_aclr = "NONE",
	altera_mult_add_component.input_c0_latency_sclr = "NONE",
	altera_mult_add_component.input_c1_latency_sclr = "NONE",
	altera_mult_add_component.input_c2_latency_sclr = "NONE",
	altera_mult_add_component.input_c3_latency_sclr = "NONE",
	altera_mult_add_component.coefsel0_latency_clock = "UNREGISTERED",
	altera_mult_add_component.coefsel1_latency_clock = "UNREGISTERED",
	altera_mult_add_component.coefsel2_latency_clock = "UNREGISTERED",
	altera_mult_add_component.coefsel3_latency_clock = "UNREGISTERED",
	altera_mult_add_component.coefsel0_latency_aclr = "NONE",
	altera_mult_add_component.coefsel1_latency_aclr = "NONE",
	altera_mult_add_component.coefsel2_latency_aclr = "NONE",
	altera_mult_add_component.coefsel3_latency_aclr = "NONE",
	altera_mult_add_component.coefsel0_latency_sclr = "NONE",
	altera_mult_add_component.coefsel1_latency_sclr = "NONE",
	altera_mult_add_component.coefsel2_latency_sclr = "NONE",
	altera_mult_add_component.coefsel3_latency_sclr = "NONE",
	altera_mult_add_component.signed_latency_clock_a = "UNREGISTERED",
	altera_mult_add_component.signed_latency_aclr_a = "NONE",
	altera_mult_add_component.signed_latency_sclr_a = "NONE",
	altera_mult_add_component.signed_latency_clock_b = "UNREGISTERED",
	altera_mult_add_component.signed_latency_aclr_b = "NONE",
	altera_mult_add_component.signed_latency_sclr_b = "NONE",
	altera_mult_add_component.addnsub_multiplier_latency_clock1 = "UNREGISTERED",
	altera_mult_add_component.addnsub_multiplier_latency_aclr1 = "NONE",
	altera_mult_add_component.addnsub_multiplier_latency_sclr1 = "NONE",
	altera_mult_add_component.addnsub_multiplier_latency_clock3 = "UNREGISTERED",
	altera_mult_add_component.addnsub_multiplier_latency_aclr3 = "NONE",
	altera_mult_add_component.addnsub_multiplier_latency_sclr3 = "NONE",
	altera_mult_add_component.accum_sload_latency_clock = "UNREGISTERED",
	altera_mult_add_component.accum_sload_latency_aclr = "NONE",
	altera_mult_add_component.accum_sload_latency_sclr = "NONE",
	altera_mult_add_component.negate_latency_clock = "UNREGISTERED",
	altera_mult_add_component.negate_latency_aclr = "NONE",
	altera_mult_add_component.negate_latency_sclr = "NONE",
	altera_mult_add_component.selected_device_family = "Cyclone V";

endmodule

