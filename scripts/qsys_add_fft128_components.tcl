# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

#Add Components
add_instance fft_sub FFT_sub

add_instance fft_ddr_bridge altera_address_span_extender 
set_instance_parameter_value fft_ddr_bridge {DATA_WIDTH} {128}
set_instance_parameter_value fft_ddr_bridge {MASTER_ADDRESS_WIDTH} {32}
set_instance_parameter_value fft_ddr_bridge {SLAVE_ADDRESS_WIDTH} {26}
set_instance_parameter_value fft_ddr_bridge {BURSTCOUNT_WIDTH} {5}
set_instance_parameter_value fft_ddr_bridge {SUB_WINDOW_COUNT} {1}
set_instance_parameter_value fft_ddr_bridge {MASTER_ADDRESS_DEF} {2147483648}
set_instance_parameter_value fft_ddr_bridge {MAX_PENDING_READS} {8}

# MM Connectivity
add_connection lw_mm_bridge.m0 fft_sub.s0 avalon
set_connection_parameter_value lw_mm_bridge.m0/fft_sub.s0 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/fft_sub.s0 baseAddress {0x00080000}
set_connection_parameter_value lw_mm_bridge.m0/fft_sub.s0 defaultConnection {0}

add_connection fft_sub.to_ddr fft_ddr_bridge.windowed_slave avalon
set_connection_parameter_value fft_sub.to_ddr/fft_ddr_bridge.windowed_slave arbitrationPriority {1}
set_connection_parameter_value fft_sub.to_ddr/fft_ddr_bridge.windowed_slave baseAddress {0x0000}
set_connection_parameter_value fft_sub.to_ddr/fft_ddr_bridge.windowed_slave defaultConnection {0}   

add_connection fft_ddr_bridge.expanded_master axi_bridge_for_acp_128_0.s0 avalon
set_connection_parameter_value fft_ddr_bridge.expanded_master/axi_bridge_for_acp_128_0.s0 arbitrationPriority {1}
set_connection_parameter_value fft_ddr_bridge.expanded_master/axi_bridge_for_acp_128_0.s0 baseAddress {0x0000}
set_connection_parameter_value fft_ddr_bridge.expanded_master/axi_bridge_for_acp_128_0.s0 defaultConnection {0}

add_connection lw_mm_bridge.m0 fft_ddr_bridge.cntl
set_connection_parameter_value lw_mm_bridge.m0/fft_ddr_bridge.cntl arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/fft_ddr_bridge.cntl baseAddress {0x00100000}
set_connection_parameter_value lw_mm_bridge.m0/fft_ddr_bridge.cntl defaultConnection {0}

# Interrupts   
add_connection hps_0.f2h_irq0 fft_sub.sgdma_from_fft_csr_irq interrupt
set_connection_parameter_value hps_0.f2h_irq0/fft_sub.sgdma_from_fft_csr_irq irqNumber {3}

add_connection hps_0.f2h_irq0 fft_sub.sgdma_to_fft_csr_irq interrupt
set_connection_parameter_value hps_0.f2h_irq0/fft_sub.sgdma_to_fft_csr_irq irqNumber {4}

add_connection hps_0.f2h_irq0 fft_sub.sgdma_from_ram_csr_irq interrupt
set_connection_parameter_value hps_0.f2h_irq0/fft_sub.sgdma_from_ram_csr_irq irqNumber {5}

# Clocks
add_connection hps_0.h2f_user0_clock fft_ddr_bridge.clock clock
add_connection hps_0.h2f_user0_clock fft_sub.clk clock

# Resets
add_connection clk_0.clk_reset fft_sub.reset reset
add_connection clk_0.clk_reset fft_ddr_bridge.reset reset
