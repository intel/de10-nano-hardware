// Copyright (c) 2016 Intel Corporation
// SPDX-License-Identifier: MIT

// fft_adapter.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module fft_adapter #(
		parameter FFT_IN_WIDTH  = 16,
		parameter FFT_OUT_WIDTH = 24,
		parameter SIZE_WIDTH    = 11
	) (
		output wire        asi_in0_ready,          //      in0.ready
		input  wire        asi_in0_valid,          //         .valid
		input  wire        asi_in0_startofpacket,  //         .startofpacket
		input  wire        asi_in0_endofpacket,    //         .endofpacket
		input  wire [1:0]  asi_in0_error,          //         .error
		input  wire [1:0]  asi_in0_empty,          //         .empty
		input  wire [(2*FFT_IN_WIDTH)-1:0] asi_in0_data,           //         .data
		input  wire        clk,                    //    clock.clk
		input  wire        reset,                  //    reset.reset
		output wire [63:0] aso_out0_data,          //     out0.data
		input  wire        aso_out0_ready,         //         .ready
		output wire        aso_out0_valid,         //         .valid
		output wire        aso_out0_startofpacket, //         .startofpacket
		output wire        aso_out0_endofpacket,   //         .endofpacket
		output wire [1:0]  aso_out0_error,         //         .error
		output wire [2:0]  aso_out0_empty,         //         .empty
		input  wire [2*FFT_OUT_WIDTH +SIZE_WIDTH -1:0] asi_fromfft_data,           // from_fft.data
		output wire        asi_fromfft_ready,          //         .ready
		input  wire        asi_fromfft_valid,          //         .valid
		input  wire        asi_fromfft_startofpacket,  //         .startofpacket
		input  wire        asi_fromfft_endofpacket,    //         .endofpacket
		input  wire [1:0]  asi_fromfft_error,          //         .error
		output wire [(2*FFT_IN_WIDTH) + SIZE_WIDTH :0] aso_tofft_data,          //   to_fft.data
		input  wire        aso_tofft_ready,         //         .ready
		output wire        aso_tofft_valid,         //         .valid
		output wire        aso_tofft_startofpacket, //         .startofpacket
		output wire        aso_tofft_endofpacket,  //         .endofpacket
		output wire  [1:0]      aso_tofft_error,         //         .error
		input  wire [1:0]  avs_s0_address,         //      csr.address
		input  wire        avs_s0_read,            //         .read
		output wire [31:0] avs_s0_readdata,        //         .readdata
		input  wire        avs_s0_write,           //         .write
		input  wire [31:0] avs_s0_writedata        //         .writedata
	);

	// TODO: Auto-generated HDL template
	//assign fft_ii_0_source_data = { fft_ii_0_source_real[23:0], fft_ii_0_source_imag[23:0], fft_ii_0_fftpts_out[10:0] };
	wire [31:0] source_real;
	wire [31:0] source_imag;
	reg [SIZE_WIDTH-1:0] size_register;
	reg direction_register;

	//CSR registger 
	//size register.
	always @ (posedge clk or posedge reset)
	begin
	if (reset)
	  size_register <= 128;
	else
	  if ((avs_s0_address ==0) && avs_s0_write)
	    size_register <= avs_s0_writedata[SIZE_WIDTH-1:0];
	end
	
	//direction register
	always @ (posedge clk or posedge reset)
	begin
	if (reset)
	  direction_register <= 0;
	else
	  if ((avs_s0_address ==1) && avs_s0_write)
	    direction_register <= avs_s0_writedata[0];
	end
	
	// read back path
	assign avs_s0_readdata = avs_s0_address[0]?{{31{1'b0}},direction_register}: {{31-SIZE_WIDTH{1'b0}}, size_register} ;
	
	
	//strip off the real and imaginary parts and sign extend the data. 
	assign source_real = {{32-FFT_OUT_WIDTH{asi_fromfft_data[SIZE_WIDTH +2*FFT_OUT_WIDTH -1]}},asi_fromfft_data[SIZE_WIDTH +2*FFT_OUT_WIDTH -1:SIZE_WIDTH +FFT_OUT_WIDTH]};
	assign source_imag = {{32-FFT_OUT_WIDTH{asi_fromfft_data[SIZE_WIDTH +FFT_OUT_WIDTH -1]}},asi_fromfft_data[SIZE_WIDTH +FFT_OUT_WIDTH -1:SIZE_WIDTH]};

	 // little endian conversion. 
	assign aso_out0_data = {source_real[7:0],source_real[15:8],source_real[23:16],source_real[31:24],
				source_imag[7:0],source_imag[15:8],source_imag[23:16],source_imag[31:24]};  //  out0.data

// signal going out to the sgdma.
	assign aso_out0_empty = 3'b000;
	
	assign aso_out0_valid = asi_fromfft_valid;

	assign aso_out0_startofpacket = asi_fromfft_startofpacket;

	assign aso_out0_endofpacket = asi_fromfft_endofpacket;

	assign aso_out0_error = asi_fromfft_error;
	

	assign asi_fromfft_ready = aso_out0_ready;

	// signals going to the fft.

	assign asi_in0_ready = aso_tofft_ready;
	
	assign aso_tofft_valid = asi_in0_valid;

	// need an endian conversion as well. 
//	assign aso_tofft_data = {asi_in0_data[7:0], asi_in0_data[15:8], asi_in0_data[23:16], asi_in0_data[31:24], size_register, direction_register};
// needed to shift the real and imaginary part for version 1.1
assign aso_tofft_data = {asi_in0_data[23:16], asi_in0_data[31:24], asi_in0_data[7:0], asi_in0_data[15:8], size_register, direction_register};

	assign aso_tofft_startofpacket = asi_in0_startofpacket;

	assign aso_tofft_endofpacket = asi_in0_endofpacket;

	assign aso_tofft_error = asi_in0_error;

//	assign aso_tofft_empty = asi_in0_empty;  // fft does not need empty

	


endmodule
