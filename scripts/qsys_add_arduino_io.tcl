# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

#HPS Modifications
set_instance_parameter_value hps_0 {SPIM0_PinMuxing} {FPGA}
set_instance_parameter_value hps_0 {SPIM0_Mode} {Full}
set_instance_parameter_value hps_0 {UART1_PinMuxing} {FPGA}
set_instance_parameter_value hps_0 {UART1_Mode} {Full}
set_instance_parameter_value hps_0 {I2C3_PinMuxing} {FPGA}
set_instance_parameter_value hps_0 {I2C3_Mode} {Full}

#Add Components
add_instance arduino_gpio altera_avalon_pio
set_instance_parameter_value arduino_gpio {bitClearingEdgeCapReg} {1}
set_instance_parameter_value arduino_gpio {bitModifyingOutReg} {1}
set_instance_parameter_value arduino_gpio {captureEdge} {1}
set_instance_parameter_value arduino_gpio {direction} {Bidir}
set_instance_parameter_value arduino_gpio {edgeType} {RISING}
set_instance_parameter_value arduino_gpio {generateIRQ} {1}
set_instance_parameter_value arduino_gpio {irqType} {EDGE}
set_instance_parameter_value arduino_gpio {resetValue} {0.0}
set_instance_parameter_value arduino_gpio {simDoTestBenchWiring} {0}
set_instance_parameter_value arduino_gpio {simDrivenValue} {0.0}
set_instance_parameter_value arduino_gpio {width} {8}

# connections and connection parameters
# LW Bridge
add_connection lw_mm_bridge.m0 arduino_gpio.s1 avalon
set_connection_parameter_value lw_mm_bridge.m0/arduino_gpio.s1 arbitrationPriority {1}
set_connection_parameter_value lw_mm_bridge.m0/arduino_gpio.s1 baseAddress {0x6000}
set_connection_parameter_value lw_mm_bridge.m0/arduino_gpio.s1 defaultConnection {0}

# Resets
add_connection clk_0.clk_reset arduino_gpio.reset reset
# Clocks
add_connection clk_0.clk arduino_gpio.clk clock

# IRQ
add_connection hps_0.f2h_irq0 arduino_gpio.irq interrupt
set_connection_parameter_value hps_0.f2h_irq0/arduino_gpio.irq irqNumber {11}

# exported interfaces    
set_interface_property hps_0_spim0 EXPORT_OF hps_0.spim0
add_interface hps_0_spim0_sclk_out clock source
set_interface_property hps_0_spim0_sclk_out EXPORT_OF hps_0.spim0_sclk_out
add_interface hps_0_uart1 conduit end
set_interface_property hps_0_uart1 EXPORT_OF hps_0.uart1
add_interface hps_0_i2c3_scl_in clock sink
set_interface_property hps_0_i2c3_scl_in EXPORT_OF hps_0.i2c3_scl_in
add_interface hps_0_i2c3_clk clock source
set_interface_property hps_0_i2c3_clk EXPORT_OF hps_0.i2c3_clk
add_interface hps_0_i2c3 conduit end
set_interface_property hps_0_i2c3 EXPORT_OF hps_0.i2c3

add_interface arduino_gpio conduit end
set_interface_property arduino_gpio EXPORT_OF arduino_gpio.external_connection
