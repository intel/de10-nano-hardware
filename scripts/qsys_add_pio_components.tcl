# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

#Add Components
add_instance led_pio altera_avalon_pio
set_instance_parameter_value led_pio {bitClearingEdgeCapReg} {0}
set_instance_parameter_value led_pio {bitModifyingOutReg} {0}
set_instance_parameter_value led_pio {captureEdge} {0}
set_instance_parameter_value led_pio {direction} {Output}
set_instance_parameter_value led_pio {edgeType} {RISING}
set_instance_parameter_value led_pio {generateIRQ} {0}
set_instance_parameter_value led_pio {irqType} {LEVEL}
set_instance_parameter_value led_pio {resetValue} {0.0}
set_instance_parameter_value led_pio {simDoTestBenchWiring} {0}
set_instance_parameter_value led_pio {simDrivenValue} {0.0}
set_instance_parameter_value led_pio {width} {8}

add_instance dipsw_pio altera_avalon_pio
set_instance_parameter_value dipsw_pio {bitClearingEdgeCapReg} {1}
set_instance_parameter_value dipsw_pio {bitModifyingOutReg} {0}
set_instance_parameter_value dipsw_pio {captureEdge} {1}
set_instance_parameter_value dipsw_pio {direction} {Input}
set_instance_parameter_value dipsw_pio {edgeType} {ANY}
set_instance_parameter_value dipsw_pio {generateIRQ} {1}
set_instance_parameter_value dipsw_pio {irqType} {EDGE}
set_instance_parameter_value dipsw_pio {resetValue} {0.0}
set_instance_parameter_value dipsw_pio {simDoTestBenchWiring} {0}
set_instance_parameter_value dipsw_pio {simDrivenValue} {0.0}
set_instance_parameter_value dipsw_pio {width} {4}

add_instance button_pio altera_avalon_pio
set_instance_parameter_value button_pio {bitClearingEdgeCapReg} {1}
set_instance_parameter_value button_pio {bitModifyingOutReg} {0}
set_instance_parameter_value button_pio {captureEdge} {1}
set_instance_parameter_value button_pio {direction} {Input}
set_instance_parameter_value button_pio {edgeType} {FALLING}
set_instance_parameter_value button_pio {generateIRQ} {1}
set_instance_parameter_value button_pio {irqType} {EDGE}
set_instance_parameter_value button_pio {resetValue} {0.0}
set_instance_parameter_value button_pio {simDoTestBenchWiring} {0}
set_instance_parameter_value button_pio {simDrivenValue} {0.0}
set_instance_parameter_value button_pio {width} {2}

# connections and connection parameters
# LW Bridge
add_connection lw_mm_bridge.m0 led_pio.s1 avalon
set_connection_parameter_value lw_mm_bridge.m0/led_pio.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/led_pio.s1 baseAddress {0x3000}
set_connection_parameter_value lw_mm_bridge.m0/led_pio.s1 defaultConnection {0}

add_connection lw_mm_bridge.m0 dipsw_pio.s1 avalon
set_connection_parameter_value lw_mm_bridge.m0/dipsw_pio.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/dipsw_pio.s1 baseAddress {0x4000}
set_connection_parameter_value lw_mm_bridge.m0/dipsw_pio.s1 defaultConnection {0}

add_connection lw_mm_bridge.m0 button_pio.s1 avalon
set_connection_parameter_value lw_mm_bridge.m0/button_pio.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/button_pio.s1 baseAddress {0x5000}
set_connection_parameter_value lw_mm_bridge.m0/button_pio.s1 defaultConnection {0}

# IRQ
add_connection hps_0.f2h_irq0 dipsw_pio.irq interrupt
set_connection_parameter_value hps_0.f2h_irq0/dipsw_pio.irq irqNumber {1}
add_connection hps_0.f2h_irq0 button_pio.irq interrupt
set_connection_parameter_value hps_0.f2h_irq0/button_pio.irq irqNumber {2}

# Clocks
add_connection clk_0.clk led_pio.clk clock
add_connection clk_0.clk dipsw_pio.clk clock
add_connection clk_0.clk button_pio.clk clock

# Resets
add_connection clk_0.clk_reset button_pio.reset reset
add_connection clk_0.clk_reset dipsw_pio.reset reset
add_connection clk_0.clk_reset led_pio.reset reset

# exported interfaces
add_interface led_pio conduit end
set_interface_property led_pio EXPORT_OF led_pio.external_connection
add_interface dipsw_pio conduit end
set_interface_property dipsw_pio EXPORT_OF dipsw_pio.external_connection
add_interface button_pio conduit end
set_interface_property button_pio EXPORT_OF button_pio.external_connection
