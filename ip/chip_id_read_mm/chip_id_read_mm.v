// Copyright (c) 2016 Intel Corporation
// SPDX-License-Identifier: MIT

`timescale 1 ps / 1 ps
module chip_id_read_mm (
		// clocks and resets
		input  wire        clk,             // clock.clk
		input  wire        reset,           // reset.reset

		// Avalon MM slave
		input  wire        avs_s0_read,     //    s0.read
		output wire [63:0] avs_s0_readdata, //      .readdata

		// Avalon ST sink
		input  wire [63:0] asi_in0_data,    //   in0.data
		output wire        asi_in0_ready    //   in0.ready
	);

	assign avs_s0_readdata = asi_in0_data;
	assign asi_in0_ready = 1'b1;

endmodule
