# The MIT License (MIT)
# Copyright (c) 2016 Intel Corporation
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


#Add Components
#add_instance hps_clk_out clock_source 
#set_instance_parameter_value hps_clk_out {clockFrequency} {50000000.0}
#set_instance_parameter_value hps_clk_out {clockFrequencyKnown} {1}
#set_instance_parameter_value hps_clk_out {resetSynchronousEdges} {NONE}
add_instance hps_reset altera_reset_bridge
set_instance_parameter_value hps_reset {ACTIVE_LOW_RESET} {1}
set_instance_parameter_value hps_reset {SYNCHRONOUS_EDGES} {deassert}
set_instance_parameter_value hps_reset {NUM_RESET_OUTPUTS} {1}
set_instance_parameter_value hps_reset {USE_RESET_REQUEST} {0}


add_instance clk_0 clock_source
set_instance_parameter_value clk_0 {clockFrequency} {50000000.0}
set_instance_parameter_value clk_0 {clockFrequencyKnown} {1}
set_instance_parameter_value clk_0 {resetSynchronousEdges} {NONE}

add_instance lw_mm_bridge altera_avalon_mm_bridge
set_instance_parameter_value lw_mm_bridge {DATA_WIDTH} {32}
set_instance_parameter_value lw_mm_bridge {SYMBOL_WIDTH} {8}
set_instance_parameter_value lw_mm_bridge {ADDRESS_WIDTH} {10}
set_instance_parameter_value lw_mm_bridge {USE_AUTO_ADDRESS_WIDTH} {1}
set_instance_parameter_value lw_mm_bridge {ADDRESS_UNITS} {SYMBOLS}
set_instance_parameter_value lw_mm_bridge {MAX_BURST_SIZE} {1}
set_instance_parameter_value lw_mm_bridge {MAX_PENDING_RESPONSES} {4}
set_instance_parameter_value lw_mm_bridge {LINEWRAPBURSTS} {0}
set_instance_parameter_value lw_mm_bridge {PIPELINE_COMMAND} {1}
set_instance_parameter_value lw_mm_bridge {PIPELINE_RESPONSE} {1}

add_instance jtag_uart altera_avalon_jtag_uart
set_instance_parameter_value jtag_uart {allowMultipleConnections} {1}
set_instance_parameter_value jtag_uart {hubInstanceID} {0}
set_instance_parameter_value jtag_uart {readBufferDepth} {64}
set_instance_parameter_value jtag_uart {readIRQThreshold} {8}
set_instance_parameter_value jtag_uart {simInputCharacterStream} {}
set_instance_parameter_value jtag_uart {simInteractiveOptions} {INTERACTIVE_ASCII_OUTPUT}
set_instance_parameter_value jtag_uart {useRegistersForReadBuffer} {0}
set_instance_parameter_value jtag_uart {useRegistersForWriteBuffer} {0}
set_instance_parameter_value jtag_uart {useRelativePathForSimFile} {0}
set_instance_parameter_value jtag_uart {writeBufferDepth} {64}
set_instance_parameter_value jtag_uart {writeIRQThreshold} {8}

add_instance onchip_memory2_0 altera_avalon_onchip_memory2
set_instance_parameter_value onchip_memory2_0 {allowInSystemMemoryContentEditor} {0}
set_instance_parameter_value onchip_memory2_0 {blockType} {AUTO}
set_instance_parameter_value onchip_memory2_0 {dataWidth} {32}
set_instance_parameter_value onchip_memory2_0 {dualPort} {0}
set_instance_parameter_value onchip_memory2_0 {initMemContent} {1}
set_instance_parameter_value onchip_memory2_0 {initializationFileName} {onchip_mem.hex}
set_instance_parameter_value onchip_memory2_0 {instanceID} {NONE}
#set_instance_parameter_value onchip_memory2_0 {memorySize} {65536.0}
set_instance_parameter_value onchip_memory2_0 {memorySize} {32768.0}
set_instance_parameter_value onchip_memory2_0 {readDuringWriteMode} {DONT_CARE}
set_instance_parameter_value onchip_memory2_0 {simAllowMRAMContentsFile} {0}
set_instance_parameter_value onchip_memory2_0 {simMemInitOnlyFilename} {0}
set_instance_parameter_value onchip_memory2_0 {singleClockOperation} {0}
set_instance_parameter_value onchip_memory2_0 {slave1Latency} {1}
set_instance_parameter_value onchip_memory2_0 {slave2Latency} {1}
set_instance_parameter_value onchip_memory2_0 {useNonDefaultInitFile} {0}
set_instance_parameter_value onchip_memory2_0 {copyInitFile} {0}
set_instance_parameter_value onchip_memory2_0 {useShallowMemBlocks} {0}
set_instance_parameter_value onchip_memory2_0 {writable} {1}
set_instance_parameter_value onchip_memory2_0 {ecc_enabled} {0}
set_instance_parameter_value onchip_memory2_0 {resetrequest_enabled} {1}

add_instance sysid_qsys altera_avalon_sysid_qsys
set_instance_parameter_value sysid_qsys {id} {-1395321854}

if {![string equal ${devkitname} {mandelbrot-de10-nano}]} {
	add_instance axi_bridge_for_acp_128_0 axi_bridge_for_acp_128
}

add_instance por power_on_reset
set_instance_parameter_value por {POR_COUNT} {20}
    
# connections and connection parameters
# LW Bridge
add_connection hps_0.h2f_lw_axi_master lw_mm_bridge.s0 avalon
set_connection_parameter_value hps_0.h2f_lw_axi_master/lw_mm_bridge.s0 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_lw_axi_master/lw_mm_bridge.s0 baseAddress {0x0000}
set_connection_parameter_value hps_0.h2f_lw_axi_master/lw_mm_bridge.s0 defaultConnection {0}

add_connection lw_mm_bridge.m0 sysid_qsys.control_slave avalon
set_connection_parameter_value lw_mm_bridge.m0/sysid_qsys.control_slave arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/sysid_qsys.control_slave baseAddress {0x1000}
set_connection_parameter_value lw_mm_bridge.m0/sysid_qsys.control_slave defaultConnection {0}

add_connection lw_mm_bridge.m0 jtag_uart.avalon_jtag_slave avalon
set_connection_parameter_value lw_mm_bridge.m0/jtag_uart.avalon_jtag_slave arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/jtag_uart.avalon_jtag_slave baseAddress {0x2000}
set_connection_parameter_value lw_mm_bridge.m0/jtag_uart.avalon_jtag_slave defaultConnection {0}

# AXI Bridge
add_connection hps_0.h2f_axi_master onchip_memory2_0.s1 avalon
set_connection_parameter_value hps_0.h2f_axi_master/onchip_memory2_0.s1 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/onchip_memory2_0.s1 baseAddress {0x0000}
set_connection_parameter_value hps_0.h2f_axi_master/onchip_memory2_0.s1 defaultConnection {0}

if {![string equal ${devkitname} {mandelbrot-de10-nano}]} {
	add_connection axi_bridge_for_acp_128_0.m0 hps_0.f2h_axi_slave avalon
	set_connection_parameter_value axi_bridge_for_acp_128_0.m0/hps_0.f2h_axi_slave arbitrationPriority {1}
	set_connection_parameter_value axi_bridge_for_acp_128_0.m0/hps_0.f2h_axi_slave baseAddress {0x0000}
	set_connection_parameter_value axi_bridge_for_acp_128_0.m0/hps_0.f2h_axi_slave defaultConnection {0}
}

# IRQ
add_connection hps_0.f2h_irq0 jtag_uart.irq interrupt
set_connection_parameter_value hps_0.f2h_irq0/jtag_uart.irq irqNumber {0}
    
# Clocks
add_connection hps_0.h2f_user1_clock hps_reset.clk clock
add_connection clk_0.clk hps_0.h2f_axi_clock clock
add_connection hps_0.h2f_user0_clock hps_0.f2h_axi_clock clock
add_connection clk_0.clk hps_0.h2f_lw_axi_clock clock
add_connection clk_0.clk lw_mm_bridge.clk clock
add_connection clk_0.clk sysid_qsys.clk clock
add_connection clk_0.clk jtag_uart.clk clock
add_connection clk_0.clk onchip_memory2_0.clk1 clock
if {![string equal ${devkitname} {mandelbrot-de10-nano}]} {
	add_connection hps_0.h2f_user0_clock axi_bridge_for_acp_128_0.clock clock
}
add_connection clk_0.clk por.clock

# Resets
add_connection hps_0.h2f_reset hps_reset.in_reset reset
add_connection clk_0.clk_reset lw_mm_bridge.reset reset
add_connection clk_0.clk_reset sysid_qsys.reset reset
add_connection clk_0.clk_reset jtag_uart.reset reset
add_connection clk_0.clk_reset onchip_memory2_0.reset1 reset
if {![string equal ${devkitname} {mandelbrot-de10-nano}]} {
	add_connection clk_0.clk_reset axi_bridge_for_acp_128_0.reset reset
}

remove_interface reset_0
add_connection por.reset clk_0.clk_in_reset
add_connection hps_0.h2f_reset clk_0.clk_in_reset

# exported interfaces
#add_interface hps_0_h2f_clk clock source
#set_interface_property hps_0_h2f_clk EXPORT_OF hps_clk_out.clk
add_interface hps_0_h2f_reset reset source
set_interface_property hps_0_h2f_reset EXPORT_OF hps_reset.out_reset
add_interface hps_0_hps_io conduit end
set_interface_property hps_0_hps_io EXPORT_OF hps_0.hps_io
add_interface memory conduit end
set_interface_property memory EXPORT_OF hps_0.memory
add_interface clk clock sink
set_interface_property clk EXPORT_OF clk_0.clk_in
#add_interface reset reset sink
#set_interface_property reset EXPORT_OF clk_0.clk_in_reset

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {0}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
