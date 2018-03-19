# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

add_instance gpio_0_a altera_avalon_pio 
set_instance_parameter_value gpio_0_a {bitClearingEdgeCapReg} {1}
set_instance_parameter_value gpio_0_a {bitModifyingOutReg} {1}
set_instance_parameter_value gpio_0_a {captureEdge} {1}
set_instance_parameter_value gpio_0_a {direction} {Bidir}
set_instance_parameter_value gpio_0_a {edgeType} {RISING}
set_instance_parameter_value gpio_0_a {generateIRQ} {0}
set_instance_parameter_value gpio_0_a {irqType} {EDGE}
set_instance_parameter_value gpio_0_a {resetValue} {0.0}
set_instance_parameter_value gpio_0_a {simDoTestBenchWiring} {0}
set_instance_parameter_value gpio_0_a {simDrivenValue} {0.0}
set_instance_parameter_value gpio_0_a {width} {18}

add_instance gpio_0_b altera_avalon_pio 
set_instance_parameter_value gpio_0_b {bitClearingEdgeCapReg} {1}
set_instance_parameter_value gpio_0_b {bitModifyingOutReg} {1}
set_instance_parameter_value gpio_0_b {captureEdge} {1}
set_instance_parameter_value gpio_0_b {direction} {Bidir}
set_instance_parameter_value gpio_0_b {edgeType} {RISING}
set_instance_parameter_value gpio_0_b {generateIRQ} {0}
set_instance_parameter_value gpio_0_b {irqType} {EDGE}
set_instance_parameter_value gpio_0_b {resetValue} {0.0}
set_instance_parameter_value gpio_0_b {simDoTestBenchWiring} {0}
set_instance_parameter_value gpio_0_b {simDrivenValue} {0.0}
set_instance_parameter_value gpio_0_b {width} {18}

add_instance gpio_1_b altera_avalon_pio
set_instance_parameter_value gpio_1_b {bitClearingEdgeCapReg} {1}
set_instance_parameter_value gpio_1_b {bitModifyingOutReg} {1}
set_instance_parameter_value gpio_1_b {captureEdge} {1}
set_instance_parameter_value gpio_1_b {direction} {Bidir}
set_instance_parameter_value gpio_1_b {edgeType} {RISING}
set_instance_parameter_value gpio_1_b {generateIRQ} {0}
set_instance_parameter_value gpio_1_b {irqType} {EDGE}
set_instance_parameter_value gpio_1_b {resetValue} {0.0}
set_instance_parameter_value gpio_1_b {simDoTestBenchWiring} {0}
set_instance_parameter_value gpio_1_b {simDrivenValue} {0.0}
set_instance_parameter_value gpio_1_b {width} {18}

add_instance gpio_1_a altera_avalon_pio
set_instance_parameter_value gpio_1_a {bitClearingEdgeCapReg} {1}
set_instance_parameter_value gpio_1_a {bitModifyingOutReg} {1}
set_instance_parameter_value gpio_1_a {captureEdge} {1}
set_instance_parameter_value gpio_1_a {direction} {Bidir}
set_instance_parameter_value gpio_1_a {edgeType} {RISING}
set_instance_parameter_value gpio_1_a {generateIRQ} {0}
set_instance_parameter_value gpio_1_a {irqType} {EDGE}
set_instance_parameter_value gpio_1_a {resetValue} {0.0}
set_instance_parameter_value gpio_1_a {simDoTestBenchWiring} {0}
set_instance_parameter_value gpio_1_a {simDrivenValue} {0.0}
set_instance_parameter_value gpio_1_a {width} {18}

# Clocks
add_connection clk_0.clk gpio_0_a.clk
add_connection clk_0.clk gpio_0_b.clk
add_connection clk_0.clk gpio_1_a.clk
add_connection clk_0.clk gpio_1_b.clk

# resets
add_connection clk_0.clk_reset gpio_0_a.reset
add_connection clk_0.clk_reset gpio_0_b.reset
add_connection clk_0.clk_reset gpio_1_a.reset
add_connection clk_0.clk_reset gpio_1_b.reset

# mm connections
add_connection lw_mm_bridge.m0 gpio_0_a.s1
set_connection_parameter_value lw_mm_bridge.m0/gpio_0_a.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/gpio_0_a.s1 baseAddress {0x00010000}
set_connection_parameter_value lw_mm_bridge.m0/gpio_0_a.s1 defaultConnection {0}

add_connection lw_mm_bridge.m0 gpio_0_b.s1
set_connection_parameter_value lw_mm_bridge.m0/gpio_0_b.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/gpio_0_b.s1 baseAddress {0x00011000}
set_connection_parameter_value lw_mm_bridge.m0/gpio_0_b.s1 defaultConnection {0}

add_connection lw_mm_bridge.m0 gpio_1_a.s1
set_connection_parameter_value lw_mm_bridge.m0/gpio_1_a.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/gpio_1_a.s1 baseAddress {0x00012000}
set_connection_parameter_value lw_mm_bridge.m0/gpio_1_a.s1 defaultConnection {0}

add_connection lw_mm_bridge.m0 gpio_1_b.s1
set_connection_parameter_value lw_mm_bridge.m0/gpio_1_b.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/gpio_1_b.s1 baseAddress {0x00013000}
set_connection_parameter_value lw_mm_bridge.m0/gpio_1_b.s1 defaultConnection {0}

# Exports
add_interface gpio_0_a conduit end
set_interface_property gpio_0_a EXPORT_OF gpio_0_a.external_connection
add_interface gpio_0_b conduit end
set_interface_property gpio_0_b EXPORT_OF gpio_0_b.external_connection
add_interface gpio_1_a conduit end
set_interface_property gpio_1_a EXPORT_OF gpio_1_a.external_connection
add_interface gpio_1_b conduit end
set_interface_property gpio_1_b EXPORT_OF gpio_1_b.external_connection
