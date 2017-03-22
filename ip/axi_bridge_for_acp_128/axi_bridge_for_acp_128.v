// The MIT License (MIT)
// Copyright (c) 2016 Intel Corporation
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


//
// This component is a simple AXI3 pass through bridge with 128-bit data path
// and 32-bit address bus.  The intent of this component is to simply condition
// the ARCACHE, ARPROT, ARUSER, AWCACHE, AWPROT, and AWUSER ports to drive an
// acceptable pattern into the HPS F2S bridge for accesses that are targeting
// the ACP port of the Cortex A9 cluster.
//

`timescale 1 ps / 1 ps
module axi_bridge_for_acp_128 (
		input  wire         clk,            // clock.clk
		input  wire         reset,          // reset.reset
		
		output wire [31:0]  axm_m0_araddr,  //    m0.araddr
		output wire [1:0]   axm_m0_arburst, //      .arburst
		output wire [3:0]   axm_m0_arcache, //      .arcache
		output wire [7:0]   axm_m0_arid,    //      .arid
		output wire [3:0]   axm_m0_arlen,   //      .arlen
		output wire [1:0]   axm_m0_arlock,  //      .arlock
		output wire [2:0]   axm_m0_arprot,  //      .arprot
		input  wire         axm_m0_arready, //      .arready
		output wire [2:0]   axm_m0_arsize,  //      .arsize
		output wire [4:0]   axm_m0_aruser,  //      .aruser
		output wire         axm_m0_arvalid, //      .arvalid
		output wire [31:0]  axm_m0_awaddr,  //      .awaddr
		output wire [1:0]   axm_m0_awburst, //      .awburst
		output wire [3:0]   axm_m0_awcache, //      .awcache
		output wire [7:0]   axm_m0_awid,    //      .awid
		output wire [3:0]   axm_m0_awlen,   //      .awlen
		output wire [1:0]   axm_m0_awlock,  //      .awlock
		output wire [2:0]   axm_m0_awprot,  //      .awprot
		input  wire         axm_m0_awready, //      .awready
		output wire [2:0]   axm_m0_awsize,  //      .awsize
		output wire [4:0]   axm_m0_awuser,  //      .awuser
		output wire         axm_m0_awvalid, //      .awvalid
		input  wire [7:0]   axm_m0_bid,     //      .bid
		output wire         axm_m0_bready,  //      .bready
		input  wire [1:0]   axm_m0_bresp,   //      .bresp
		input  wire         axm_m0_bvalid,  //      .bvalid
		input  wire [127:0] axm_m0_rdata,   //      .rdata
		input  wire [7:0]   axm_m0_rid,     //      .rid
		input  wire         axm_m0_rlast,   //      .rlast
		output wire         axm_m0_rready,  //      .rready
		input  wire [1:0]   axm_m0_rresp,   //      .rresp
		input  wire         axm_m0_rvalid,  //      .rvalid
		output wire [127:0] axm_m0_wdata,   //      .wdata
		output wire [7:0]   axm_m0_wid,     //      .wid
		output wire         axm_m0_wlast,   //      .wlast
		input  wire         axm_m0_wready,  //      .wready
		output wire [15:0]  axm_m0_wstrb,   //      .wstrb
		output wire         axm_m0_wvalid,  //      .wvalid
		
		input  wire [31:0]  axs_s0_araddr,  //    s0.araddr
		input  wire [1:0]   axs_s0_arburst, //      .arburst
		input  wire [3:0]   axs_s0_arcache, //      .arcache
		input  wire [7:0]   axs_s0_arid,    //      .arid
		input  wire [3:0]   axs_s0_arlen,   //      .arlen
		input  wire [1:0]   axs_s0_arlock,  //      .arlock
		input  wire [2:0]   axs_s0_arprot,  //      .arprot
		output wire         axs_s0_arready, //      .arready
		input  wire [2:0]   axs_s0_arsize,  //      .arsize
		input  wire [4:0]   axs_s0_aruser,  //      .aruser
		input  wire         axs_s0_arvalid, //      .arvalid
		input  wire [31:0]  axs_s0_awaddr,  //      .awaddr
		input  wire [1:0]   axs_s0_awburst, //      .awburst
		input  wire [3:0]   axs_s0_awcache, //      .awcache
		input  wire [7:0]   axs_s0_awid,    //      .awid
		input  wire [3:0]   axs_s0_awlen,   //      .awlen
		input  wire [1:0]   axs_s0_awlock,  //      .awlock
		input  wire [2:0]   axs_s0_awprot,  //      .awprot
		output wire         axs_s0_awready, //      .awready
		input  wire [2:0]   axs_s0_awsize,  //      .awsize
		input  wire [4:0]   axs_s0_awuser,  //      .awuser
		input  wire         axs_s0_awvalid, //      .awvalid
		output wire [7:0]   axs_s0_bid,     //      .bid
		input  wire         axs_s0_bready,  //      .bready
		output wire [1:0]   axs_s0_bresp,   //      .bresp
		output wire         axs_s0_bvalid,  //      .bvalid
		output wire [127:0] axs_s0_rdata,   //      .rdata
		output wire [7:0]   axs_s0_rid,     //      .rid
		output wire         axs_s0_rlast,   //      .rlast
		input  wire         axs_s0_rready,  //      .rready
		output wire [1:0]   axs_s0_rresp,   //      .rresp
		output wire         axs_s0_rvalid,  //      .rvalid
		input  wire [127:0] axs_s0_wdata,   //      .wdata
		input  wire [7:0]   axs_s0_wid,     //      .wid
		input  wire         axs_s0_wlast,   //      .wlast
		output wire         axs_s0_wready,  //      .wready
		input  wire [15:0]  axs_s0_wstrb,   //      .wstrb
		input  wire         axs_s0_wvalid   //      .wvalid
	);

	assign axm_m0_araddr = axs_s0_araddr;
	assign axm_m0_arburst = axs_s0_arburst;
	assign axm_m0_arcache = 4'b1111;
	assign axm_m0_arid = axs_s0_arid;
	assign axm_m0_arlen = axs_s0_arlen;
	assign axm_m0_arlock = axs_s0_arlock;
	assign axm_m0_arprot = 3'b000;
	assign axm_m0_arsize = axs_s0_arsize;
	assign axm_m0_aruser = 5'b00001;
	assign axm_m0_arvalid = axs_s0_arvalid;
	assign axm_m0_awaddr = axs_s0_awaddr;
	assign axm_m0_awburst = axs_s0_awburst;
	assign axm_m0_awcache = 4'b1111;
	assign axm_m0_awid = axs_s0_awid;
	assign axm_m0_awlen = axs_s0_awlen;
	assign axm_m0_awlock = axs_s0_awlock;
	assign axm_m0_awprot = 3'b000;
	assign axm_m0_awsize = axs_s0_awsize;
	assign axm_m0_awuser = 5'b00001;
	assign axm_m0_awvalid = axs_s0_awvalid;
	assign axm_m0_bready = axs_s0_bready;
	assign axm_m0_rready = axs_s0_rready;
	assign axm_m0_wdata = axs_s0_wdata;
	assign axm_m0_wid = axs_s0_wid;
	assign axm_m0_wlast = axs_s0_wlast;
	assign axm_m0_wstrb = axs_s0_wstrb;
	assign axm_m0_wvalid = axs_s0_wvalid;
	assign axs_s0_arready = axm_m0_arready;
	assign axs_s0_awready = axm_m0_awready;
	assign axs_s0_bid = axm_m0_bid;
	assign axs_s0_bresp = axm_m0_bresp;
	assign axs_s0_bvalid = axm_m0_bvalid;
	assign axs_s0_rdata = axm_m0_rdata;
	assign axs_s0_rid = axm_m0_rid;
	assign axs_s0_rlast = axm_m0_rlast;
	assign axs_s0_rresp = axm_m0_rresp;
	assign axs_s0_rvalid = axm_m0_rvalid;
	assign axs_s0_wready = axm_m0_wready;
	
endmodule

