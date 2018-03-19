# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

# 50MHz board input clock
create_clock -period 20 [get_ports fpga_clk1_50]

# for enhancing USB BlasterII to be reliable, 25MHz
#create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck 3 [get_ports altera_reserved_tdo]

# FPGA IO port constraints
set_false_path -from [get_ports {fpga_dipsw_pio[0]}] -to *
set_false_path -from [get_ports {fpga_dipsw_pio[1]}] -to *
set_false_path -from [get_ports {fpga_dipsw_pio[2]}] -to *
set_false_path -from [get_ports {fpga_dipsw_pio[3]}] -to *
set_false_path -from * -to [get_ports {fpga_led_pio[0]}]
set_false_path -from * -to [get_ports {fpga_led_pio[1]}]
set_false_path -from * -to [get_ports {fpga_led_pio[2]}]
set_false_path -from * -to [get_ports {fpga_led_pio[3]}]
set_false_path -from * -to [get_ports {fpga_led_pio[4]}]
set_false_path -from * -to [get_ports {fpga_led_pio[5]}]
set_false_path -from * -to [get_ports {fpga_led_pio[6]}]
set_false_path -from * -to [get_ports {fpga_led_pio[7]}]
set_false_path -from [get_ports {fpga_key_pio[0]}] -to *
set_false_path -from [get_ports {fpga_key_pio[1]}] -to *
set_false_path -from [get_ports {gpio_0[*]}] -to *
set_false_path -from [get_ports {gpio_1[*]}] -to *
set_false_path -from * -to [get_ports {gpio_0[*]}]
set_false_path -from * -to [get_ports {gpio_1[*]}]

# HPS peripherals port false path setting to workaround the
# unconstraint path (setting false_path for hps_0 ports will
# not affect the routing as it is hard silicon)
set_false_path -from * -to [get_ports {hps_emac1_TX_CLK}] 
set_false_path -from * -to [get_ports {hps_emac1_TXD0}] 
set_false_path -from * -to [get_ports {hps_emac1_TXD1}] 
set_false_path -from * -to [get_ports {hps_emac1_TXD2}] 
set_false_path -from * -to [get_ports {hps_emac1_TXD3}] 
set_false_path -from * -to [get_ports {hps_emac1_MDC}] 
set_false_path -from * -to [get_ports {hps_emac1_TX_CTL}] 
set_false_path -from * -to [get_ports {hps_sdio_CLK}] 
set_false_path -from * -to [get_ports {hps_usb1_STP}] 
set_false_path -from * -to [get_ports {hps_spim1_CLK}] 
set_false_path -from * -to [get_ports {hps_spim1_MOSI}] 
set_false_path -from * -to [get_ports {hps_spim1_SS0}]
set_false_path -from * -to [get_ports {hps_uart0_TX}] 

set_false_path -from * -to [get_ports {hps_emac1_MDIO}] 
set_false_path -from * -to [get_ports {hps_sdio_CMD}] 
set_false_path -from * -to [get_ports {hps_sdio_D0}] 
set_false_path -from * -to [get_ports {hps_sdio_D1}] 
set_false_path -from * -to [get_ports {hps_sdio_D2}] 
set_false_path -from * -to [get_ports {hps_sdio_D3}] 
set_false_path -from * -to [get_ports {hps_usb1_D0}] 
set_false_path -from * -to [get_ports {hps_usb1_D1}] 
set_false_path -from * -to [get_ports {hps_usb1_D2}] 
set_false_path -from * -to [get_ports {hps_usb1_D3}] 
set_false_path -from * -to [get_ports {hps_usb1_D4}] 
set_false_path -from * -to [get_ports {hps_usb1_D5}] 
set_false_path -from * -to [get_ports {hps_usb1_D6}] 
set_false_path -from * -to [get_ports {hps_usb1_D7}] 
set_false_path -from * -to [get_ports {hps_i2c0_SDA}] 
set_false_path -from * -to [get_ports {hps_i2c0_SCL}] 
set_false_path -from * -to [get_ports {hps_i2c1_SDA}] 
set_false_path -from * -to [get_ports {hps_i2c1_SCL}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO09}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO35}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO40}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO53}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO54}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO61}]

set_false_path -from [get_ports {hps_emac1_MDIO}] -to *
set_false_path -from [get_ports {hps_sdio_CMD}] -to *
set_false_path -from [get_ports {hps_sdio_D0}] -to *
set_false_path -from [get_ports {hps_sdio_D1}] -to *
set_false_path -from [get_ports {hps_sdio_D2}] -to *
set_false_path -from [get_ports {hps_sdio_D3}] -to *
set_false_path -from [get_ports {hps_usb1_D0}] -to *
set_false_path -from [get_ports {hps_usb1_D1}] -to *
set_false_path -from [get_ports {hps_usb1_D2}] -to *
set_false_path -from [get_ports {hps_usb1_D3}] -to *
set_false_path -from [get_ports {hps_usb1_D4}] -to *
set_false_path -from [get_ports {hps_usb1_D5}] -to *
set_false_path -from [get_ports {hps_usb1_D6}] -to *
set_false_path -from [get_ports {hps_usb1_D7}] -to *
set_false_path -from [get_ports {hps_i2c0_SDA}] -to *
set_false_path -from [get_ports {hps_i2c0_SCL}] -to *
set_false_path -from [get_ports {hps_i2c1_SDA}] -to *
set_false_path -from [get_ports {hps_i2c1_SCL}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO09}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO35}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO40}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO53}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO54}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO61}] -to *

set_false_path -from [get_ports {hps_emac1_RX_CTL}] -to *
set_false_path -from [get_ports {hps_emac1_RX_CLK}] -to *
set_false_path -from [get_ports {hps_emac1_RXD0}] -to *
set_false_path -from [get_ports {hps_emac1_RXD1}] -to *
set_false_path -from [get_ports {hps_emac1_RXD2}] -to *
set_false_path -from [get_ports {hps_emac1_RXD3}] -to *
set_false_path -from [get_ports {hps_usb1_CLK}] -to *
set_false_path -from [get_ports {hps_usb1_DIR}] -to *
set_false_path -from [get_ports {hps_usb1_NXT}] -to *
set_false_path -from [get_ports {hps_spim1_MISO}] -to *
set_false_path -from [get_ports {hps_spim1_SS0}] -to *
set_false_path -from [get_ports {hps_uart0_RX}] -to *

# create unused clock constraint for HPS I2C and usb1
# to avoid misleading unconstraint clock reporting in TimeQuest
create_clock -period "1 MHz" [get_ports hps_i2c0_SCL]
create_clock -period "1 MHz" [get_ports hps_i2c1_SCL]
create_clock -period "48 MHz" [get_ports hps_usb1_CLK]


#
# Arduino IO
#

# ALT_IOBUF arduino_scl_iobuf (.i(1'b0), .oe(arduino_internal_scl_o_e), .o(arduino_internal_scl_o), .io(arduino_io[15]));
# ALT_IOBUF arduino_sda_iobuf (.i(1'b0), .oe(arduino_internal_sda_o_e), .o(arduino_internal_sda_o), .io(arduino_io[14]));
set_false_path -from [get_ports arduino_io[15]] -to *
set_false_path -from * -to [get_ports arduino_io[15]]
set_false_path -from [get_ports arduino_io[14]] -to *
set_false_path -from * -to [get_ports arduino_io[14]]

# ALT_IOBUF arduino_uart_rx_iobuf (.i(1'b0), .oe(1'b0), .o(arduino_hps_0_uart1_rxd), .io(arduino_io[0]));
# ALT_IOBUF arduino_uart_tx_iobuf (.i(arduino_hps_0_uart1_txd), .oe(1'b1), .o(), .io(arduino_io[1]));
set_false_path -from [get_ports arduino_io[0]] -to *
set_false_path -from * -to [get_ports arduino_io[1]]

# ALT_IOBUF arduino_ss_iobuf (.i(arduino_hps_0_spim0_ss_0_n), .oe(!arduino_hps_0_spim0_ssi_oe_n), .o(arduino_hps_0_spim0_ss_in_n), .io(arduino_io[10]));
# ALT_IOBUF arduino_mosi_iobuf (.i(arduino_hps_0_spim0_txd), .oe(1'b1), .o(), .io(arduino_io[11]));
# ALT_IOBUF arduino_miso_iobuf (.i(1'b0), .oe(1'b0), .o(arduino_hps_0_spim0_rxd), .io(arduino_io[12]));
# ALT_IOBUF arduino_sck_iobuf (.i(arduino_hps_0_spim0_sclk_out_clk), .oe(1'b1), .o(), .io(arduino_io[13]));
set_false_path -from [get_ports arduino_io[10]] -to *
set_false_path -from * -to [get_ports arduino_io[10]]
set_false_path -from * -to [get_ports arduino_io[11]]
set_false_path -from [get_ports arduino_io[12]] -to *
set_false_path -from * -to [get_ports arduino_io[13]]

# .arduino_gpio_export              (arduino_io[9:2]),
set_false_path -from [get_ports arduino_io[2]] -to *
set_false_path -from * -to [get_ports arduino_io[2]]
set_false_path -from [get_ports arduino_io[3]] -to *
set_false_path -from * -to [get_ports arduino_io[3]]
set_false_path -from [get_ports arduino_io[4]] -to *
set_false_path -from * -to [get_ports arduino_io[4]]
set_false_path -from [get_ports arduino_io[5]] -to *
set_false_path -from * -to [get_ports arduino_io[5]]
set_false_path -from [get_ports arduino_io[6]] -to *
set_false_path -from * -to [get_ports arduino_io[6]]
set_false_path -from [get_ports arduino_io[7]] -to *
set_false_path -from * -to [get_ports arduino_io[7]]
set_false_path -from [get_ports arduino_io[8]] -to *
set_false_path -from * -to [get_ports arduino_io[8]]
set_false_path -from [get_ports arduino_io[9]] -to *
set_false_path -from * -to [get_ports arduino_io[9]]

# assign arduino_reset_n = hps_fpga_reset_n;
set_false_path -from * -to [get_ports arduino_reset_n]
