# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

#hps modification
set_instance_parameter_value hps_0 {F2SDRAM_Type} {Avalon-MM\ Bidirectional}
set_instance_parameter_value hps_0 {F2SDRAM_Width} {256}

#Add Components
add_instance clk_hdmi altera_clock_bridge

add_instance custom_reset_synchronizer custom_reset_synchronizer
set_instance_parameter_value custom_reset_synchronizer {INPUT_CLOCK_FREQUENCY} {148500000}
set_instance_parameter_value custom_reset_synchronizer {INPUT_CLOCK_KNOWN} {1}
set_instance_parameter_value custom_reset_synchronizer {SYNC_DEPTH} {3}
set_instance_parameter_value custom_reset_synchronizer {ADDITIONAL_DEPTH} {2}
set_instance_parameter_value custom_reset_synchronizer {DISABLE_GLOBAL_NETWORK} {1}
set_instance_parameter_value custom_reset_synchronizer {SYNC_BOTH_EDGES} {0}

add_instance hdmi_mm_bridge altera_avalon_mm_bridge
set_instance_parameter_value hdmi_mm_bridge {DATA_WIDTH} {32}
set_instance_parameter_value hdmi_mm_bridge {SYMBOL_WIDTH} {8}
set_instance_parameter_value hdmi_mm_bridge {ADDRESS_WIDTH} {10}
set_instance_parameter_value hdmi_mm_bridge {USE_AUTO_ADDRESS_WIDTH} {1}
set_instance_parameter_value hdmi_mm_bridge {ADDRESS_UNITS} {SYMBOLS}
set_instance_parameter_value hdmi_mm_bridge {MAX_BURST_SIZE} {1}
set_instance_parameter_value hdmi_mm_bridge {MAX_PENDING_RESPONSES} {4}
set_instance_parameter_value hdmi_mm_bridge {LINEWRAPBURSTS} {0}
set_instance_parameter_value hdmi_mm_bridge {PIPELINE_COMMAND} {1}
set_instance_parameter_value hdmi_mm_bridge {PIPELINE_RESPONSE} {1}
set_instance_parameter_value hdmi_mm_bridge {USE_RESPONSE} {0}

add_instance cvo_reset_conduit conduit_to_reset
set_instance_parameter_value cvo_reset_conduit {INPUT_CONDUIT_ROLE} {export}

add_instance cvo_reset_pio altera_avalon_pio
set_instance_parameter_value cvo_reset_pio {bitClearingEdgeCapReg} {0}
set_instance_parameter_value cvo_reset_pio {bitModifyingOutReg} {1}
set_instance_parameter_value cvo_reset_pio {captureEdge} {0}
set_instance_parameter_value cvo_reset_pio {direction} {Output}
set_instance_parameter_value cvo_reset_pio {edgeType} {RISING}
set_instance_parameter_value cvo_reset_pio {generateIRQ} {0}
set_instance_parameter_value cvo_reset_pio {irqType} {LEVEL}
set_instance_parameter_value cvo_reset_pio {resetValue} {0.0}
set_instance_parameter_value cvo_reset_pio {simDoTestBenchWiring} {0}
set_instance_parameter_value cvo_reset_pio {simDrivenValue} {0.0}
set_instance_parameter_value cvo_reset_pio {width} {1}

add_instance pll_reset_conduit conduit_to_reset
set_instance_parameter_value pll_reset_conduit {INPUT_CONDUIT_ROLE} {export}

add_instance pll_reset_pio altera_avalon_pio
set_instance_parameter_value pll_reset_pio {bitClearingEdgeCapReg} {0}
set_instance_parameter_value pll_reset_pio {bitModifyingOutReg} {1}
set_instance_parameter_value pll_reset_pio {captureEdge} {0}
set_instance_parameter_value pll_reset_pio {direction} {Output}
set_instance_parameter_value pll_reset_pio {edgeType} {RISING}
set_instance_parameter_value pll_reset_pio {generateIRQ} {0}
set_instance_parameter_value pll_reset_pio {irqType} {LEVEL}
set_instance_parameter_value pll_reset_pio {resetValue} {0.0}
set_instance_parameter_value pll_reset_pio {simDoTestBenchWiring} {0}
set_instance_parameter_value pll_reset_pio {simDrivenValue} {0.0}
set_instance_parameter_value pll_reset_pio {width} {1}

add_instance locked_pio altera_avalon_pio
set_instance_parameter_value locked_pio {bitClearingEdgeCapReg} {0}
set_instance_parameter_value locked_pio {bitModifyingOutReg} {1}
set_instance_parameter_value locked_pio {captureEdge} {0}
set_instance_parameter_value locked_pio {direction} {Input}
set_instance_parameter_value locked_pio {edgeType} {RISING}
set_instance_parameter_value locked_pio {generateIRQ} {0}
set_instance_parameter_value locked_pio {irqType} {LEVEL}
set_instance_parameter_value locked_pio {resetValue} {0.0}
set_instance_parameter_value locked_pio {simDoTestBenchWiring} {0}
set_instance_parameter_value locked_pio {simDrivenValue} {0.0}
set_instance_parameter_value locked_pio {width} {1}

add_instance alt_vip_cl_cvo_hdmi alt_vip_cl_cvo 
set_instance_parameter_value alt_vip_cl_cvo_hdmi {BPS} {8}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {NUMBER_OF_COLOUR_PLANES} {4}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {COLOUR_PLANES_ARE_IN_PARALLEL} {1}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {INTERLACED} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {H_ACTIVE_PIXELS} {1920}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {V_ACTIVE_LINES} {1080}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {ACCEPT_COLOURS_IN_SEQ} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {FIFO_DEPTH} {1920}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {CLOCKS_ARE_SAME} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {USE_CONTROL} {1}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {NO_OF_MODES} {1}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {THRESHOLD} {1919}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {STD_WIDTH} {1}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {GENERATE_SYNC} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {LOW_LATENCY} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {USE_EMBEDDED_SYNCS} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {AP_LINE} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {V_BLANK} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {H_BLANK} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {H_SYNC_LENGTH} {32}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {H_FRONT_PORCH} {32}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {H_BACK_PORCH} {64}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {V_SYNC_LENGTH} {3}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {V_FRONT_PORCH} {1}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {V_BACK_PORCH} {27}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {F_RISING_EDGE} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {F_FALLING_EDGE} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {FIELD0_V_RISING_EDGE} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {FIELD0_V_BLANK} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {FIELD0_V_SYNC_LENGTH} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {FIELD0_V_FRONT_PORCH} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {FIELD0_V_BACK_PORCH} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {ANC_LINE} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {FIELD0_ANC_LINE} {0}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {PIXELS_IN_PARALLEL} {1}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {NO_OF_CHANNELS} {1}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {SRC_WIDTH} {8}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {DST_WIDTH} {8}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {CONTEXT_WIDTH} {8}
set_instance_parameter_value alt_vip_cl_cvo_hdmi {TASK_WIDTH} {8}

add_instance alt_vip_cl_vfb_hdmi alt_vip_cl_vfb
set_instance_parameter_value alt_vip_cl_vfb_hdmi {BITS_PER_SYMBOL} {8}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {NUMBER_OF_COLOR_PLANES} {4}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {COLOR_PLANES_ARE_IN_PARALLEL} {1}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {PIXELS_IN_PARALLEL} {1}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {READY_LATENCY} {1}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {MAX_WIDTH} {1920}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {MAX_HEIGHT} {1080}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {CLOCKS_ARE_SEPARATE} {1}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {MEM_PORT_WIDTH} {256}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {MEM_BASE_ADDR} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {USE_BUFFER_OFFSET} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {MEM_BUFFER_OFFSET} {16777216}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {BURST_ALIGNMENT} {1}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {WRITE_FIFO_DEPTH} {8}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {WRITE_BURST_TARGET} {2}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {READ_FIFO_DEPTH} {256}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {READ_BURST_TARGET} {32}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {WRITER_RUNTIME_CONTROL} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {READER_RUNTIME_CONTROL} {1}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {IS_FRAME_WRITER} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {IS_FRAME_READER} {1}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {DROP_FRAMES} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {REPEAT_FRAMES} {1}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {DROP_REPEAT_USER} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {INTERLACED_SUPPORT} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {CONTROLLED_DROP_REPEAT} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {DROP_INVALID_FIELDS} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {MULTI_FRAME_DELAY} {1}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {IS_SYNC_MASTER} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {IS_SYNC_SLAVE} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {USER_PACKETS_MAX_STORAGE} {0}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {MAX_SYMBOLS_PER_PACKET} {10}
set_instance_parameter_value alt_vip_cl_vfb_hdmi {TEST_INIT} {0}

add_instance pll_stream altera_pll
set_instance_parameter_value pll_stream {debug_print_output} {0}
set_instance_parameter_value pll_stream {debug_use_rbc_taf_method} {0}
set_instance_parameter_value pll_stream {gui_device_speed_grade} {2}
set_instance_parameter_value pll_stream {gui_pll_mode} {Fractional-N PLL}
set_instance_parameter_value pll_stream {gui_reference_clock_frequency} {50.0}
set_instance_parameter_value pll_stream {gui_channel_spacing} {0.0}
set_instance_parameter_value pll_stream {gui_operation_mode} {direct}
set_instance_parameter_value pll_stream {gui_feedback_clock} {Global Clock}
set_instance_parameter_value pll_stream {gui_fractional_cout} {32}
set_instance_parameter_value pll_stream {gui_dsm_out_sel} {1st_order}
set_instance_parameter_value pll_stream {gui_use_locked} {1}
set_instance_parameter_value pll_stream {gui_en_adv_params} {0}
set_instance_parameter_value pll_stream {gui_number_of_clocks} {1}
set_instance_parameter_value pll_stream {gui_multiply_factor} {1}
set_instance_parameter_value pll_stream {gui_frac_multiply_factor} {1.0}
set_instance_parameter_value pll_stream {gui_divide_factor_n} {1}
set_instance_parameter_value pll_stream {gui_cascade_counter0} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency0} {148.5}
set_instance_parameter_value pll_stream {gui_divide_factor_c0} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency0} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units0} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift0} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg0} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift0} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle0} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter1} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency1} {65.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c1} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency1} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units1} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift1} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg1} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift1} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle1} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter2} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency2} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c2} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency2} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units2} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift2} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg2} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift2} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle2} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter3} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency3} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c3} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency3} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units3} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift3} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg3} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift3} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle3} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter4} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency4} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c4} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency4} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units4} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift4} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg4} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift4} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle4} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter5} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency5} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c5} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency5} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units5} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift5} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg5} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift5} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle5} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter6} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency6} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c6} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency6} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units6} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift6} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg6} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift6} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle6} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter7} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency7} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c7} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency7} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units7} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift7} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg7} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift7} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle7} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter8} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency8} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c8} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency8} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units8} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift8} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg8} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift8} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle8} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter9} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency9} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c9} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency9} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units9} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift9} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg9} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift9} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle9} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter10} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency10} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c10} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency10} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units10} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift10} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg10} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift10} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle10} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter11} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency11} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c11} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency11} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units11} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift11} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg11} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift11} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle11} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter12} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency12} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c12} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency12} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units12} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift12} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg12} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift12} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle12} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter13} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency13} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c13} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency13} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units13} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift13} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg13} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift13} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle13} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter14} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency14} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c14} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency14} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units14} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift14} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg14} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift14} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle14} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter15} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency15} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c15} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency15} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units15} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift15} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg15} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift15} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle15} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter16} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency16} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c16} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency16} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units16} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift16} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg16} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift16} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle16} {50}
set_instance_parameter_value pll_stream {gui_cascade_counter17} {0}
set_instance_parameter_value pll_stream {gui_output_clock_frequency17} {100.0}
set_instance_parameter_value pll_stream {gui_divide_factor_c17} {1}
set_instance_parameter_value pll_stream {gui_actual_output_clock_frequency17} {0 MHz}
set_instance_parameter_value pll_stream {gui_ps_units17} {ps}
set_instance_parameter_value pll_stream {gui_phase_shift17} {0}
set_instance_parameter_value pll_stream {gui_phase_shift_deg17} {0.0}
set_instance_parameter_value pll_stream {gui_actual_phase_shift17} {0}
set_instance_parameter_value pll_stream {gui_duty_cycle17} {50}
set_instance_parameter_value pll_stream {gui_pll_auto_reset} {Off}
set_instance_parameter_value pll_stream {gui_pll_bandwidth_preset} {Auto}
set_instance_parameter_value pll_stream {gui_en_reconf} {1}
set_instance_parameter_value pll_stream {gui_en_dps_ports} {0}
set_instance_parameter_value pll_stream {gui_en_phout_ports} {0}
set_instance_parameter_value pll_stream {gui_phout_division} {1}
set_instance_parameter_value pll_stream {gui_mif_generate} {0}
set_instance_parameter_value pll_stream {gui_enable_mif_dps} {0}
set_instance_parameter_value pll_stream {gui_dps_cntr} {C0}
set_instance_parameter_value pll_stream {gui_dps_num} {1}
set_instance_parameter_value pll_stream {gui_dps_dir} {Positive}
set_instance_parameter_value pll_stream {gui_refclk_switch} {0}
set_instance_parameter_value pll_stream {gui_refclk1_frequency} {100.0}
set_instance_parameter_value pll_stream {gui_switchover_mode} {Automatic Switchover}
set_instance_parameter_value pll_stream {gui_switchover_delay} {0}
set_instance_parameter_value pll_stream {gui_active_clk} {0}
set_instance_parameter_value pll_stream {gui_clk_bad} {0}
set_instance_parameter_value pll_stream {gui_enable_cascade_out} {0}
set_instance_parameter_value pll_stream {gui_cascade_outclk_index} {0}
set_instance_parameter_value pll_stream {gui_enable_cascade_in} {0}
set_instance_parameter_value pll_stream {gui_pll_cascading_mode} {Create an adjpllin signal to connect with an upstream PLL}

add_instance pll_stream_reconfig altera_pll_reconfig
set_instance_parameter_value pll_stream_reconfig {ENABLE_MIF} {0}
set_instance_parameter_value pll_stream_reconfig {MIF_FILE_NAME} {}
set_instance_parameter_value pll_stream_reconfig {ENABLE_BYTEENABLE} {1}

# exported interfaces
add_interface alt_vip_cl_cvo_hdmi_clocked_video conduit end
set_interface_property alt_vip_cl_cvo_hdmi_clocked_video EXPORT_OF alt_vip_cl_cvo_hdmi.clocked_video

add_interface clk_hdmi clock source
set_interface_property clk_hdmi EXPORT_OF clk_hdmi.out_clk

# connections and connection parameters
add_connection lw_mm_bridge.m0 hdmi_mm_bridge.s0
set_connection_parameter_value lw_mm_bridge.m0/hdmi_mm_bridge.s0 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/hdmi_mm_bridge.s0 baseAddress {0x8000}
set_connection_parameter_value lw_mm_bridge.m0/hdmi_mm_bridge.s0 defaultConnection {0}

add_connection lw_mm_bridge.m0 pll_stream_reconfig.mgmt_avalon_slave
set_connection_parameter_value lw_mm_bridge.m0/pll_stream_reconfig.mgmt_avalon_slave arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/pll_stream_reconfig.mgmt_avalon_slave baseAddress {0xa000}
set_connection_parameter_value lw_mm_bridge.m0/pll_stream_reconfig.mgmt_avalon_slave defaultConnection {0}

add_connection lw_mm_bridge.m0 pll_reset_pio.s1
set_connection_parameter_value lw_mm_bridge.m0/pll_reset_pio.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/pll_reset_pio.s1 baseAddress {0xb000}
set_connection_parameter_value lw_mm_bridge.m0/pll_reset_pio.s1 defaultConnection {0}

add_connection lw_mm_bridge.m0 cvo_reset_pio.s1
set_connection_parameter_value lw_mm_bridge.m0/cvo_reset_pio.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/cvo_reset_pio.s1 baseAddress {0xc000}
set_connection_parameter_value lw_mm_bridge.m0/cvo_reset_pio.s1 defaultConnection {0}

add_connection lw_mm_bridge.m0 locked_pio.s1
set_connection_parameter_value lw_mm_bridge.m0/locked_pio.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/locked_pio.s1 baseAddress {0xd000}
set_connection_parameter_value lw_mm_bridge.m0/locked_pio.s1 defaultConnection {0}

add_connection alt_vip_cl_vfb_hdmi.mem_master_rd hps_0.f2h_sdram0_data
set_connection_parameter_value alt_vip_cl_vfb_hdmi.mem_master_rd/hps_0.f2h_sdram0_data arbitrationPriority {1}
set_connection_parameter_value alt_vip_cl_vfb_hdmi.mem_master_rd/hps_0.f2h_sdram0_data baseAddress {0x0000}
set_connection_parameter_value alt_vip_cl_vfb_hdmi.mem_master_rd/hps_0.f2h_sdram0_data defaultConnection {0}

add_connection hdmi_mm_bridge.m0 alt_vip_cl_vfb_hdmi.control
set_connection_parameter_value hdmi_mm_bridge.m0/alt_vip_cl_vfb_hdmi.control arbitrationPriority {1}
set_connection_parameter_value hdmi_mm_bridge.m0/alt_vip_cl_vfb_hdmi.control baseAddress {0x0000}
set_connection_parameter_value hdmi_mm_bridge.m0/alt_vip_cl_vfb_hdmi.control defaultConnection {0}

add_connection hdmi_mm_bridge.m0 alt_vip_cl_cvo_hdmi.control
set_connection_parameter_value hdmi_mm_bridge.m0/alt_vip_cl_cvo_hdmi.control arbitrationPriority {1}
set_connection_parameter_value hdmi_mm_bridge.m0/alt_vip_cl_cvo_hdmi.control baseAddress {0x1000}
set_connection_parameter_value hdmi_mm_bridge.m0/alt_vip_cl_cvo_hdmi.control defaultConnection {0}

add_connection pll_reset_pio.external_connection pll_reset_conduit.input_conduit
set_connection_parameter_value pll_reset_pio.external_connection/pll_reset_conduit.input_conduit endPort {}
set_connection_parameter_value pll_reset_pio.external_connection/pll_reset_conduit.input_conduit endPortLSB {0}
set_connection_parameter_value pll_reset_pio.external_connection/pll_reset_conduit.input_conduit startPort {}
set_connection_parameter_value pll_reset_pio.external_connection/pll_reset_conduit.input_conduit startPortLSB {0}
set_connection_parameter_value pll_reset_pio.external_connection/pll_reset_conduit.input_conduit width {0}

add_connection cvo_reset_pio.external_connection cvo_reset_conduit.input_conduit
set_connection_parameter_value cvo_reset_pio.external_connection/cvo_reset_conduit.input_conduit endPort {}
set_connection_parameter_value cvo_reset_pio.external_connection/cvo_reset_conduit.input_conduit endPortLSB {0}
set_connection_parameter_value cvo_reset_pio.external_connection/cvo_reset_conduit.input_conduit startPort {}
set_connection_parameter_value cvo_reset_pio.external_connection/cvo_reset_conduit.input_conduit startPortLSB {0}
set_connection_parameter_value cvo_reset_pio.external_connection/cvo_reset_conduit.input_conduit width {0}

add_connection pll_stream.locked locked_pio.external_connection
set_connection_parameter_value pll_stream.locked/locked_pio.external_connection endPort {}
set_connection_parameter_value pll_stream.locked/locked_pio.external_connection endPortLSB {0}
set_connection_parameter_value pll_stream.locked/locked_pio.external_connection startPort {}
set_connection_parameter_value pll_stream.locked/locked_pio.external_connection startPortLSB {0}
set_connection_parameter_value pll_stream.locked/locked_pio.external_connection width {0}

add_connection pll_stream_reconfig.reconfig_from_pll pll_stream.reconfig_from_pll
set_connection_parameter_value pll_stream_reconfig.reconfig_from_pll/pll_stream.reconfig_from_pll endPort {}
set_connection_parameter_value pll_stream_reconfig.reconfig_from_pll/pll_stream.reconfig_from_pll endPortLSB {0}
set_connection_parameter_value pll_stream_reconfig.reconfig_from_pll/pll_stream.reconfig_from_pll startPort {}
set_connection_parameter_value pll_stream_reconfig.reconfig_from_pll/pll_stream.reconfig_from_pll startPortLSB {0}
set_connection_parameter_value pll_stream_reconfig.reconfig_from_pll/pll_stream.reconfig_from_pll width {0}

add_connection pll_stream.reconfig_to_pll pll_stream_reconfig.reconfig_to_pll
set_connection_parameter_value pll_stream.reconfig_to_pll/pll_stream_reconfig.reconfig_to_pll endPort {}
set_connection_parameter_value pll_stream.reconfig_to_pll/pll_stream_reconfig.reconfig_to_pll endPortLSB {0}
set_connection_parameter_value pll_stream.reconfig_to_pll/pll_stream_reconfig.reconfig_to_pll startPort {}
set_connection_parameter_value pll_stream.reconfig_to_pll/pll_stream_reconfig.reconfig_to_pll startPortLSB {0}
set_connection_parameter_value pll_stream.reconfig_to_pll/pll_stream_reconfig.reconfig_to_pll width {0}

add_connection alt_vip_cl_vfb_hdmi.dout alt_vip_cl_cvo_hdmi.din

#Interrupts
add_connection hps_0.f2h_irq0 alt_vip_cl_cvo_hdmi.status_update_irq
set_connection_parameter_value hps_0.f2h_irq0/alt_vip_cl_cvo_hdmi.status_update_irq irqNumber {9}
add_connection hps_0.f2h_irq0 alt_vip_cl_vfb_hdmi.control_interrupt
set_connection_parameter_value hps_0.f2h_irq0/alt_vip_cl_vfb_hdmi.control_interrupt irqNumber {10}

# Clocks
add_connection clk_0.clk locked_pio.clk
add_connection clk_0.clk cvo_reset_pio.clk
add_connection clk_0.clk pll_reset_pio.clk
add_connection clk_0.clk pll_stream.refclk
add_connection hps_0.h2f_user0_clock alt_vip_cl_vfb_hdmi.mem_clock
add_connection clk_0.clk pll_stream_reconfig.mgmt_clk
add_connection hps_0.h2f_user0_clock hps_0.f2h_sdram0_clock
#add_connection pll_stream.outclk0 clk_hdmi.in_clk
#add_connection pll_stream.outclk0 alt_vip_cl_vfb_hdmi.main_clock
#add_connection pll_stream.outclk0 alt_vip_cl_cvo_hdmi.main_clock
#add_connection pll_stream.outclk0 hdmi_mm_bridge.clk

add_connection pll_stream.outclk0 custom_reset_synchronizer.clock_in

add_connection custom_reset_synchronizer.clock_out hdmi_mm_bridge.clk
add_connection custom_reset_synchronizer.clock_out clk_hdmi.in_clk
add_connection custom_reset_synchronizer.clock_out alt_vip_cl_cvo_hdmi.main_clock
add_connection custom_reset_synchronizer.clock_out alt_vip_cl_vfb_hdmi.main_clock



# Resets
#add_connection clk_0.clk_reset alt_vip_cl_vfb_hdmi.main_reset
#add_connection clk_0.clk_reset alt_vip_cl_cvo_hdmi.main_reset
#add_connection clk_0.clk_reset alt_vip_cl_vfb_hdmi.mem_reset
add_connection clk_0.clk_reset pll_stream_reconfig.mgmt_reset
add_connection clk_0.clk_reset locked_pio.reset
add_connection clk_0.clk_reset cvo_reset_pio.reset
add_connection clk_0.clk_reset pll_reset_pio.reset
#add_connection clk_0.clk_reset hdmi_mm_bridge.reset

add_connection clk_0.clk_reset custom_reset_synchronizer.reset_in
add_connection cvo_reset_conduit.output_reset custom_reset_synchronizer.reset_in

add_connection custom_reset_synchronizer.reset_out hdmi_mm_bridge.reset
add_connection custom_reset_synchronizer.reset_out alt_vip_cl_cvo_hdmi.main_reset
add_connection custom_reset_synchronizer.reset_out alt_vip_cl_vfb_hdmi.main_reset
add_connection custom_reset_synchronizer.reset_out alt_vip_cl_vfb_hdmi.mem_reset

#add_connection cvo_reset_conduit.output_reset alt_vip_cl_cvo_hdmi.main_reset
#add_connection cvo_reset_conduit.output_reset alt_vip_cl_vfb_hdmi.main_reset
#add_connection cvo_reset_conduit.output_reset alt_vip_cl_vfb_hdmi.mem_reset

add_connection pll_reset_conduit.output_reset pll_stream.reset
#add_connection pll_reset_conduit.output_reset hdmi_mm_bridge.reset

# exported interfaces
add_interface alt_vip_cl_cvo_hdmi_clocked_video conduit end
set_interface_property alt_vip_cl_cvo_hdmi_clocked_video EXPORT_OF alt_vip_cl_cvo_hdmi.clocked_video
add_interface clk_hdmi clock source
set_interface_property clk_hdmi EXPORT_OF clk_hdmi.out_clk
