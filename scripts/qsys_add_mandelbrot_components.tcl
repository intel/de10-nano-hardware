# Copyright (c) 2017 Intel Corporation
# SPDX-License-Identifier: MIT

# Instances and instance parameters
add_instance mandelbrot_subsys_0 mandelbrot_subsys

add_instance mm_clock_crossing_bridge_0 altera_avalon_mm_clock_crossing_bridge
set_instance_parameter_value mm_clock_crossing_bridge_0 {ADDRESS_UNITS} {SYMBOLS}
set_instance_parameter_value mm_clock_crossing_bridge_0 {ADDRESS_WIDTH} {10}
set_instance_parameter_value mm_clock_crossing_bridge_0 {COMMAND_FIFO_DEPTH} {128}
set_instance_parameter_value mm_clock_crossing_bridge_0 {DATA_WIDTH} {256}
set_instance_parameter_value mm_clock_crossing_bridge_0 {MASTER_SYNC_DEPTH} {2}
set_instance_parameter_value mm_clock_crossing_bridge_0 {MAX_BURST_SIZE} {128}
set_instance_parameter_value mm_clock_crossing_bridge_0 {RESPONSE_FIFO_DEPTH} {256}
set_instance_parameter_value mm_clock_crossing_bridge_0 {SLAVE_SYNC_DEPTH} {2}
set_instance_parameter_value mm_clock_crossing_bridge_0 {SYMBOL_WIDTH} {8}
set_instance_parameter_value mm_clock_crossing_bridge_0 {USE_AUTO_ADDRESS_WIDTH} {1}

add_instance pll_70m altera_pll
set_instance_parameter_value pll_70m {debug_print_output} {0}
set_instance_parameter_value pll_70m {debug_use_rbc_taf_method} {0}
set_instance_parameter_value pll_70m {gui_active_clk} {0}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency0} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency1} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency10} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency11} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency12} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency13} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency14} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency15} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency16} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency17} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency2} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency3} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency4} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency5} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency6} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency7} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency8} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_output_clock_frequency9} {0 MHz}
set_instance_parameter_value pll_70m {gui_actual_phase_shift0} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift1} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift10} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift11} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift12} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift13} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift14} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift15} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift16} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift17} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift2} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift3} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift4} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift5} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift6} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift7} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift8} {0}
set_instance_parameter_value pll_70m {gui_actual_phase_shift9} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter0} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter1} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter10} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter11} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter12} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter13} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter14} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter15} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter16} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter17} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter2} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter3} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter4} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter5} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter6} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter7} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter8} {0}
set_instance_parameter_value pll_70m {gui_cascade_counter9} {0}
set_instance_parameter_value pll_70m {gui_cascade_outclk_index} {0}
set_instance_parameter_value pll_70m {gui_channel_spacing} {0.0}
set_instance_parameter_value pll_70m {gui_clk_bad} {0}
set_instance_parameter_value pll_70m {gui_device_speed_grade} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c0} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c1} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c10} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c11} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c12} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c13} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c14} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c15} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c16} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c17} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c2} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c3} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c4} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c5} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c6} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c7} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c8} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_c9} {1}
set_instance_parameter_value pll_70m {gui_divide_factor_n} {1}
set_instance_parameter_value pll_70m {gui_dps_cntr} {C0}
set_instance_parameter_value pll_70m {gui_dps_dir} {Positive}
set_instance_parameter_value pll_70m {gui_dps_num} {1}
set_instance_parameter_value pll_70m {gui_dsm_out_sel} {1st_order}
set_instance_parameter_value pll_70m {gui_duty_cycle0} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle1} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle10} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle11} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle12} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle13} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle14} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle15} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle16} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle17} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle2} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle3} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle4} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle5} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle6} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle7} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle8} {50}
set_instance_parameter_value pll_70m {gui_duty_cycle9} {50}
set_instance_parameter_value pll_70m {gui_en_adv_params} {0}
set_instance_parameter_value pll_70m {gui_en_dps_ports} {0}
set_instance_parameter_value pll_70m {gui_en_phout_ports} {0}
set_instance_parameter_value pll_70m {gui_en_reconf} {0}
set_instance_parameter_value pll_70m {gui_enable_cascade_in} {0}
set_instance_parameter_value pll_70m {gui_enable_cascade_out} {0}
set_instance_parameter_value pll_70m {gui_enable_mif_dps} {0}
set_instance_parameter_value pll_70m {gui_feedback_clock} {Global Clock}
set_instance_parameter_value pll_70m {gui_frac_multiply_factor} {1.0}
set_instance_parameter_value pll_70m {gui_fractional_cout} {32}
set_instance_parameter_value pll_70m {gui_mif_generate} {0}
set_instance_parameter_value pll_70m {gui_multiply_factor} {1}
set_instance_parameter_value pll_70m {gui_number_of_clocks} {1}
set_instance_parameter_value pll_70m {gui_operation_mode} {direct}
set_instance_parameter_value pll_70m {gui_output_clock_frequency0} {70.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency1} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency10} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency11} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency12} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency13} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency14} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency15} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency16} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency17} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency2} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency3} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency4} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency5} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency6} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency7} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency8} {100.0}
set_instance_parameter_value pll_70m {gui_output_clock_frequency9} {100.0}
set_instance_parameter_value pll_70m {gui_phase_shift0} {0}
set_instance_parameter_value pll_70m {gui_phase_shift1} {0}
set_instance_parameter_value pll_70m {gui_phase_shift10} {0}
set_instance_parameter_value pll_70m {gui_phase_shift11} {0}
set_instance_parameter_value pll_70m {gui_phase_shift12} {0}
set_instance_parameter_value pll_70m {gui_phase_shift13} {0}
set_instance_parameter_value pll_70m {gui_phase_shift14} {0}
set_instance_parameter_value pll_70m {gui_phase_shift15} {0}
set_instance_parameter_value pll_70m {gui_phase_shift16} {0}
set_instance_parameter_value pll_70m {gui_phase_shift17} {0}
set_instance_parameter_value pll_70m {gui_phase_shift2} {0}
set_instance_parameter_value pll_70m {gui_phase_shift3} {0}
set_instance_parameter_value pll_70m {gui_phase_shift4} {0}
set_instance_parameter_value pll_70m {gui_phase_shift5} {0}
set_instance_parameter_value pll_70m {gui_phase_shift6} {0}
set_instance_parameter_value pll_70m {gui_phase_shift7} {0}
set_instance_parameter_value pll_70m {gui_phase_shift8} {0}
set_instance_parameter_value pll_70m {gui_phase_shift9} {0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg0} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg1} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg10} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg11} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg12} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg13} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg14} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg15} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg16} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg17} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg2} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg3} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg4} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg5} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg6} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg7} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg8} {0.0}
set_instance_parameter_value pll_70m {gui_phase_shift_deg9} {0.0}
set_instance_parameter_value pll_70m {gui_phout_division} {1}
set_instance_parameter_value pll_70m {gui_pll_auto_reset} {Off}
set_instance_parameter_value pll_70m {gui_pll_bandwidth_preset} {Auto}
set_instance_parameter_value pll_70m {gui_pll_cascading_mode} {Create an adjpllin signal to connect with an upstream PLL}
set_instance_parameter_value pll_70m {gui_pll_mode} {Integer-N PLL}
set_instance_parameter_value pll_70m {gui_ps_units0} {ps}
set_instance_parameter_value pll_70m {gui_ps_units1} {ps}
set_instance_parameter_value pll_70m {gui_ps_units10} {ps}
set_instance_parameter_value pll_70m {gui_ps_units11} {ps}
set_instance_parameter_value pll_70m {gui_ps_units12} {ps}
set_instance_parameter_value pll_70m {gui_ps_units13} {ps}
set_instance_parameter_value pll_70m {gui_ps_units14} {ps}
set_instance_parameter_value pll_70m {gui_ps_units15} {ps}
set_instance_parameter_value pll_70m {gui_ps_units16} {ps}
set_instance_parameter_value pll_70m {gui_ps_units17} {ps}
set_instance_parameter_value pll_70m {gui_ps_units2} {ps}
set_instance_parameter_value pll_70m {gui_ps_units3} {ps}
set_instance_parameter_value pll_70m {gui_ps_units4} {ps}
set_instance_parameter_value pll_70m {gui_ps_units5} {ps}
set_instance_parameter_value pll_70m {gui_ps_units6} {ps}
set_instance_parameter_value pll_70m {gui_ps_units7} {ps}
set_instance_parameter_value pll_70m {gui_ps_units8} {ps}
set_instance_parameter_value pll_70m {gui_ps_units9} {ps}
set_instance_parameter_value pll_70m {gui_refclk1_frequency} {100.0}
set_instance_parameter_value pll_70m {gui_refclk_switch} {0}
set_instance_parameter_value pll_70m {gui_reference_clock_frequency} {50.0}
set_instance_parameter_value pll_70m {gui_switchover_delay} {0}
set_instance_parameter_value pll_70m {gui_switchover_mode} {Automatic Switchover}
set_instance_parameter_value pll_70m {gui_use_locked} {0}

# connections and connection parameters
add_connection clk_0.clk_reset mandelbrot_subsys_0.reset

add_connection hps_0.f2h_irq0 mandelbrot_subsys_0.mandelbrot_interrupt_pio_0_irq
set_connection_parameter_value hps_0.f2h_irq0/mandelbrot_subsys_0.mandelbrot_interrupt_pio_0_irq irqNumber {3}

add_connection hps_0.h2f_lw_axi_master mandelbrot_subsys_0.mandelbrot_subsys_s0
set_connection_parameter_value hps_0.h2f_lw_axi_master/mandelbrot_subsys_0.mandelbrot_subsys_s0 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_lw_axi_master/mandelbrot_subsys_0.mandelbrot_subsys_s0 baseAddress {0x00100000}
set_connection_parameter_value hps_0.h2f_lw_axi_master/mandelbrot_subsys_0.mandelbrot_subsys_s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_0_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_0_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_0_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_0_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_10_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_10_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_10_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_10_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_11_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_11_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_11_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_11_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_1_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_1_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_1_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_1_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_2_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_2_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_2_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_2_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_3_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_3_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_3_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_3_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_4_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_4_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_4_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_4_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_5_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_5_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_5_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_5_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_6_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_6_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_6_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_6_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_7_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_7_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_7_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_7_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_8_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_8_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_8_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_8_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection mandelbrot_subsys_0.me_sub_9_dma mm_clock_crossing_bridge_0.s0
set_connection_parameter_value mandelbrot_subsys_0.me_sub_9_dma/mm_clock_crossing_bridge_0.s0 arbitrationPriority {1}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_9_dma/mm_clock_crossing_bridge_0.s0 baseAddress {0x0000}
set_connection_parameter_value mandelbrot_subsys_0.me_sub_9_dma/mm_clock_crossing_bridge_0.s0 defaultConnection {0}

add_connection pll_70m.outclk0 mandelbrot_subsys_0.clk

add_connection clk_0.clk_reset mm_clock_crossing_bridge_0.m0_reset

add_connection clk_0.clk_reset mm_clock_crossing_bridge_0.s0_reset

add_connection hps_0.h2f_user0_clock mm_clock_crossing_bridge_0.m0_clk

add_connection mm_clock_crossing_bridge_0.m0 hps_0.f2h_sdram0_data
set_connection_parameter_value mm_clock_crossing_bridge_0.m0/hps_0.f2h_sdram0_data arbitrationPriority {1}
set_connection_parameter_value mm_clock_crossing_bridge_0.m0/hps_0.f2h_sdram0_data baseAddress {0x0000}
set_connection_parameter_value mm_clock_crossing_bridge_0.m0/hps_0.f2h_sdram0_data defaultConnection {0}

add_connection pll_70m.outclk0 mm_clock_crossing_bridge_0.s0_clk

add_connection clk_0.clk pll_70m.refclk

add_connection por.reset pll_70m.reset

