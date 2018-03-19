# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

#Add Components
add_instance altchip_id_0 altchip_id 
set_instance_parameter_value altchip_id_0 {ID_VALUE} {18446744073709551615}

add_instance chip_id_read_mm_0 chip_id_read_mm

# connections and connection parameters
# LW Bridge
add_connection lw_mm_bridge.m0 chip_id_read_mm_0.s0
set_connection_parameter_value lw_mm_bridge.m0/chip_id_read_mm_0.s0 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/chip_id_read_mm_0.s0 baseAddress {0x7000}
set_connection_parameter_value lw_mm_bridge.m0/chip_id_read_mm_0.s0 defaultConnection {0}

# AvST
add_connection altchip_id_0.output chip_id_read_mm_0.in0 avalon_streaming

# Clocks
add_connection clk_0.clk chip_id_read_mm_0.clock clock
add_connection clk_0.clk altchip_id_0.clkin clock

# Resets
add_connection clk_0.clk_reset altchip_id_0.reset reset
add_connection clk_0.clk_reset chip_id_read_mm_0.reset reset
