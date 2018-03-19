# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

# axi_bridge_for_acp_128 "axi_bridge_for_acp_128" v1.0
# RSF 2015.03.21.02:13:37
# Simple AXI3 bridge to condition CACHE, PROT and USER ports for ACP operation.
# 

# 
# request TCL package from ACDS 14.1
# 
package require -exact qsys 14.1


# 
# module axi_bridge_for_acp_128
# 
set_module_property DESCRIPTION "Simple AXI3 bridge to condition CACHE, PROT and USER ports for ACP operation."
set_module_property NAME axi_bridge_for_acp_128
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME axi_bridge_for_acp_128
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL axi_bridge_for_acp_128
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file axi_bridge_for_acp_128.v VERILOG PATH axi_bridge_for_acp_128.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL axi_bridge_for_acp_128
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file axi_bridge_for_acp_128.v VERILOG PATH axi_bridge_for_acp_128.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL axi_bridge_for_acp_128
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file axi_bridge_for_acp_128.v VERILOG PATH axi_bridge_for_acp_128.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point m0
# 
add_interface m0 axi start
set_interface_property m0 associatedClock clock
set_interface_property m0 associatedReset reset
set_interface_property m0 readIssuingCapability 16
set_interface_property m0 writeIssuingCapability 16
set_interface_property m0 combinedIssuingCapability 16
set_interface_property m0 ENABLED true
set_interface_property m0 EXPORT_OF ""
set_interface_property m0 PORT_NAME_MAP ""
set_interface_property m0 CMSIS_SVD_VARIABLES ""
set_interface_property m0 SVD_ADDRESS_GROUP ""

add_interface_port m0 axm_m0_araddr araddr Output 32
add_interface_port m0 axm_m0_arburst arburst Output 2
add_interface_port m0 axm_m0_arcache arcache Output 4
add_interface_port m0 axm_m0_arid arid Output 8
add_interface_port m0 axm_m0_arlen arlen Output 4
add_interface_port m0 axm_m0_arlock arlock Output 2
add_interface_port m0 axm_m0_arprot arprot Output 3
add_interface_port m0 axm_m0_arready arready Input 1
add_interface_port m0 axm_m0_arsize arsize Output 3
add_interface_port m0 axm_m0_aruser aruser Output 5
add_interface_port m0 axm_m0_arvalid arvalid Output 1
add_interface_port m0 axm_m0_awaddr awaddr Output 32
add_interface_port m0 axm_m0_awburst awburst Output 2
add_interface_port m0 axm_m0_awcache awcache Output 4
add_interface_port m0 axm_m0_awid awid Output 8
add_interface_port m0 axm_m0_awlen awlen Output 4
add_interface_port m0 axm_m0_awlock awlock Output 2
add_interface_port m0 axm_m0_awprot awprot Output 3
add_interface_port m0 axm_m0_awready awready Input 1
add_interface_port m0 axm_m0_awsize awsize Output 3
add_interface_port m0 axm_m0_awuser awuser Output 5
add_interface_port m0 axm_m0_awvalid awvalid Output 1
add_interface_port m0 axm_m0_bid bid Input 8
add_interface_port m0 axm_m0_bready bready Output 1
add_interface_port m0 axm_m0_bresp bresp Input 2
add_interface_port m0 axm_m0_bvalid bvalid Input 1
add_interface_port m0 axm_m0_rdata rdata Input 128
add_interface_port m0 axm_m0_rid rid Input 8
add_interface_port m0 axm_m0_rlast rlast Input 1
add_interface_port m0 axm_m0_rready rready Output 1
add_interface_port m0 axm_m0_rresp rresp Input 2
add_interface_port m0 axm_m0_rvalid rvalid Input 1
add_interface_port m0 axm_m0_wdata wdata Output 128
add_interface_port m0 axm_m0_wid wid Output 8
add_interface_port m0 axm_m0_wlast wlast Output 1
add_interface_port m0 axm_m0_wready wready Input 1
add_interface_port m0 axm_m0_wstrb wstrb Output 16
add_interface_port m0 axm_m0_wvalid wvalid Output 1


# 
# connection point s0
# 
add_interface s0 axi end
set_interface_property s0 associatedClock clock
set_interface_property s0 associatedReset reset
set_interface_property s0 readAcceptanceCapability 16
set_interface_property s0 writeAcceptanceCapability 16
set_interface_property s0 combinedAcceptanceCapability 16
set_interface_property s0 readDataReorderingDepth 1
set_interface_property s0 bridgesToMaster "m0"
set_interface_property s0 ENABLED true
set_interface_property s0 EXPORT_OF ""
set_interface_property s0 PORT_NAME_MAP ""
set_interface_property s0 CMSIS_SVD_VARIABLES ""
set_interface_property s0 SVD_ADDRESS_GROUP ""

add_interface_port s0 axs_s0_araddr araddr Input 32
add_interface_port s0 axs_s0_arburst arburst Input 2
add_interface_port s0 axs_s0_arcache arcache Input 4
add_interface_port s0 axs_s0_arid arid Input 8
add_interface_port s0 axs_s0_arlen arlen Input 4
add_interface_port s0 axs_s0_arlock arlock Input 2
add_interface_port s0 axs_s0_arprot arprot Input 3
add_interface_port s0 axs_s0_arready arready Output 1
add_interface_port s0 axs_s0_arsize arsize Input 3
add_interface_port s0 axs_s0_aruser aruser Input 5
add_interface_port s0 axs_s0_arvalid arvalid Input 1
add_interface_port s0 axs_s0_awaddr awaddr Input 32
add_interface_port s0 axs_s0_awburst awburst Input 2
add_interface_port s0 axs_s0_awcache awcache Input 4
add_interface_port s0 axs_s0_awid awid Input 8
add_interface_port s0 axs_s0_awlen awlen Input 4
add_interface_port s0 axs_s0_awlock awlock Input 2
add_interface_port s0 axs_s0_awprot awprot Input 3
add_interface_port s0 axs_s0_awready awready Output 1
add_interface_port s0 axs_s0_awsize awsize Input 3
add_interface_port s0 axs_s0_awuser awuser Input 5
add_interface_port s0 axs_s0_awvalid awvalid Input 1
add_interface_port s0 axs_s0_bid bid Output 8
add_interface_port s0 axs_s0_bready bready Input 1
add_interface_port s0 axs_s0_bresp bresp Output 2
add_interface_port s0 axs_s0_bvalid bvalid Output 1
add_interface_port s0 axs_s0_rdata rdata Output 128
add_interface_port s0 axs_s0_rid rid Output 8
add_interface_port s0 axs_s0_rlast rlast Output 1
add_interface_port s0 axs_s0_rready rready Input 1
add_interface_port s0 axs_s0_rresp rresp Output 2
add_interface_port s0 axs_s0_rvalid rvalid Output 1
add_interface_port s0 axs_s0_wdata wdata Input 128
add_interface_port s0 axs_s0_wid wid Input 8
add_interface_port s0 axs_s0_wlast wlast Input 1
add_interface_port s0 axs_s0_wready wready Output 1
add_interface_port s0 axs_s0_wstrb wstrb Input 16
add_interface_port s0 axs_s0_wvalid wvalid Input 1

