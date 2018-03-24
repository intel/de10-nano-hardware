# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

set devicefamily CYCLONEV
#set device 5CSXFC6C6U23I7
set device 5CSEBA6U23I7DK

set qipfiles ""
set hdlfiles "../hdl_src/top.v,../ip/debounce/debounce.v"
set topname top

if {[regexp {,} $qipfiles]} {
  set qipfilelist [split $qipfiles ,]
} else {
  set qipfilelist $qipfiles
}

if {[regexp {,} $hdlfiles]} {
  set hdlfilelist [split $hdlfiles ,]
} else {
  set hdlfilelist $hdlfiles
}

set_global_assignment -name FAMILY $devicefamily
set_global_assignment -name DEVICE $device

set_global_assignment -name TOP_LEVEL_ENTITY $topname

foreach qipfile $qipfilelist {
  set_global_assignment -name QIP_FILE $qipfile
}

foreach hdlfile $hdlfilelist {
  set_global_assignment -name VERILOG_FILE $hdlfile
}

# SPECIFY BOARD NAME MACRO
set_global_assignment -name VERILOG_MACRO "DE10_NANO_BASE=1" 

#set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
set_global_assignment -name EDA_SIMULATION_TOOL "<None>"
set_global_assignment -name EDA_OUTPUT_DATA_FORMAT NONE -section_id eda_simulation
set_global_assignment -name SDC_FILE ../hdl_src/soc_system_timing.sdc
set_global_assignment -name SDC_FILE ../hdl_src/soc_system_hdmi_i2c_only.sdc
set_global_assignment -name BLOCK_RAM_TO_MLAB_CELL_CONVERSION OFF

set_parameter -name MEM_A_WIDTH 15
set_parameter -name MEM_BA_WIDTH 3
set_parameter -name MEM_D_WIDTH 32

# Compiler Assignments
# ====================
set_global_assignment -name OPTIMIZATION_MODE "AGGRESSIVE PERFORMANCE"
set_global_assignment -name PHYSICAL_SYNTHESIS_COMBO_LOGIC_FOR_AREA ON
set_global_assignment -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON

# Pin & Location Assignments
# ==========================
set_location_assignment PIN_V11 -to fpga_clk1_50
set_location_assignment PIN_Y13 -to fpga_clk2_50
set_location_assignment PIN_E11 -to fpga_clk3_50    
  
set_location_assignment PIN_AH17 -to fpga_key_pio[0]
set_location_assignment PIN_AH16 -to fpga_key_pio[1]

set_location_assignment PIN_W15  -to fpga_led_pio[0]
set_location_assignment PIN_AA24 -to fpga_led_pio[1]
set_location_assignment PIN_V16  -to fpga_led_pio[2]
set_location_assignment PIN_V15  -to fpga_led_pio[3]
set_location_assignment PIN_AF26 -to fpga_led_pio[4]
set_location_assignment PIN_AE26 -to fpga_led_pio[5]
set_location_assignment PIN_Y16  -to fpga_led_pio[6]                      
set_location_assignment PIN_AA23 -to fpga_led_pio[7]

set_location_assignment PIN_Y24 -to fpga_dipsw_pio[0]
set_location_assignment PIN_W24 -to fpga_dipsw_pio[1]
set_location_assignment PIN_W21 -to fpga_dipsw_pio[2]
set_location_assignment PIN_W20 -to fpga_dipsw_pio[3]

set_location_assignment PIN_V12  -to gpio_0[0]
set_location_assignment PIN_E8   -to gpio_0[1]
set_location_assignment PIN_W12  -to gpio_0[2]
set_location_assignment PIN_D11  -to gpio_0[3]
set_location_assignment PIN_D8   -to gpio_0[4]
set_location_assignment PIN_AH13 -to gpio_0[5]
set_location_assignment PIN_AF7  -to gpio_0[6]
set_location_assignment PIN_AH14 -to gpio_0[7]

set_location_assignment PIN_AF4  -to gpio_0[8]
set_location_assignment PIN_AH3  -to gpio_0[9]
set_location_assignment PIN_AD5  -to gpio_0[10]
set_location_assignment PIN_AG14 -to gpio_0[11]
set_location_assignment PIN_AE23 -to gpio_0[12]
set_location_assignment PIN_AE6  -to gpio_0[13]
set_location_assignment PIN_AD23 -to gpio_0[14]
set_location_assignment PIN_AE24 -to gpio_0[15]

set_location_assignment PIN_D12  -to gpio_0[16]
set_location_assignment PIN_AD20 -to gpio_0[17]
set_location_assignment PIN_C12  -to gpio_0[18]
set_location_assignment PIN_AD17 -to gpio_0[19]
set_location_assignment PIN_AC23 -to gpio_0[20]
set_location_assignment PIN_AC22 -to gpio_0[21]
set_location_assignment PIN_Y19  -to gpio_0[22]
set_location_assignment PIN_AB23 -to gpio_0[23]

set_location_assignment PIN_AA19 -to gpio_0[24]
set_location_assignment PIN_W11  -to gpio_0[25]
set_location_assignment PIN_AA18 -to gpio_0[26]
set_location_assignment PIN_W14  -to gpio_0[27]
set_location_assignment PIN_Y18  -to gpio_0[28]
set_location_assignment PIN_Y17  -to gpio_0[29]
set_location_assignment PIN_AB25 -to gpio_0[30]
set_location_assignment PIN_AB26 -to gpio_0[31]

set_location_assignment PIN_Y11  -to gpio_0[32]
set_location_assignment PIN_AA26 -to gpio_0[33]
set_location_assignment PIN_AA13 -to gpio_0[34]
set_location_assignment PIN_AA11 -to gpio_0[35]

set_location_assignment PIN_Y15  -to gpio_1[0]
set_location_assignment PIN_AC24 -to gpio_1[1]
set_location_assignment PIN_AA15 -to gpio_1[2]
set_location_assignment PIN_AD26 -to gpio_1[3]
set_location_assignment PIN_AG28 -to gpio_1[4]
set_location_assignment PIN_AF28 -to gpio_1[5]
set_location_assignment PIN_AE25 -to gpio_1[6]
set_location_assignment PIN_AF27 -to gpio_1[7]
set_location_assignment PIN_AG26 -to gpio_1[8]
set_location_assignment PIN_AH27 -to gpio_1[9]
set_location_assignment PIN_AG25 -to gpio_1[10]
set_location_assignment PIN_AH26 -to gpio_1[11]
set_location_assignment PIN_AH24 -to gpio_1[12]
set_location_assignment PIN_AF25 -to gpio_1[13]
set_location_assignment PIN_AG23 -to gpio_1[14]
set_location_assignment PIN_AF23 -to gpio_1[15]
set_location_assignment PIN_AG24 -to gpio_1[16]
set_location_assignment PIN_AH22 -to gpio_1[17]
set_location_assignment PIN_AH21 -to gpio_1[18]
set_location_assignment PIN_AG21 -to gpio_1[19]
set_location_assignment PIN_AH23 -to gpio_1[20]
set_location_assignment PIN_AA20 -to gpio_1[21]
set_location_assignment PIN_AF22 -to gpio_1[22]
set_location_assignment PIN_AE22 -to gpio_1[23]
set_location_assignment PIN_AG20 -to gpio_1[24]
set_location_assignment PIN_AF21 -to gpio_1[25]
set_location_assignment PIN_AG19 -to gpio_1[26]
set_location_assignment PIN_AH19 -to gpio_1[27]
set_location_assignment PIN_AG18 -to gpio_1[28]
set_location_assignment PIN_AH18 -to gpio_1[29]
set_location_assignment PIN_AF18 -to gpio_1[30]
set_location_assignment PIN_AF20 -to gpio_1[31]
set_location_assignment PIN_AG15 -to gpio_1[32]          
set_location_assignment PIN_AE20 -to gpio_1[33]
set_location_assignment PIN_AE19 -to gpio_1[34]
set_location_assignment PIN_AE17 -to gpio_1[35]

set_location_assignment PIN_U9  -to  adc_convst  
set_location_assignment PIN_V10 -to adc_sck
set_location_assignment PIN_AC4 -to adc_sdi
set_location_assignment PIN_AD4 -to adc_sdo

set_location_assignment PIN_AG13 -to arduino_io[0]
set_location_assignment PIN_AF13 -to arduino_io[1]
set_location_assignment PIN_AG10 -to arduino_io[2]
set_location_assignment PIN_AG9  -to arduino_io[3]
set_location_assignment PIN_U14  -to arduino_io[4]
set_location_assignment PIN_U13  -to arduino_io[5]
set_location_assignment PIN_AG8  -to arduino_io[6]
set_location_assignment PIN_AH8  -to arduino_io[7]
set_location_assignment PIN_AF17 -to arduino_io[8]
set_location_assignment PIN_AE15 -to arduino_io[9]
set_location_assignment PIN_AF15 -to arduino_io[10]
set_location_assignment PIN_AG16 -to arduino_io[11]
set_location_assignment PIN_AH11 -to arduino_io[12]
set_location_assignment PIN_AH12 -to arduino_io[13]
set_location_assignment PIN_AH9  -to arduino_io[14]
set_location_assignment PIN_AG11 -to arduino_io[15]
set_location_assignment PIN_AH7  -to arduino_reset_n 

set_location_assignment PIN_U10  -to hdmi_i2c_scl
set_location_assignment PIN_AA4  -to hdmi_i2c_sda
set_location_assignment PIN_T13  -to hdmi_i2s
set_location_assignment PIN_T11  -to hdmi_lrclk
set_location_assignment PIN_U11  -to hdmi_mclk
set_location_assignment PIN_T12  -to hdmi_sclk
set_location_assignment PIN_AG5  -to hdmi_tx_clk
set_location_assignment PIN_AD12 -to hdmi_tx_d[0]
set_location_assignment PIN_AE12 -to hdmi_tx_d[1]
set_location_assignment PIN_W8   -to hdmi_tx_d[2]
set_location_assignment PIN_Y8   -to hdmi_tx_d[3]
set_location_assignment PIN_AD11 -to hdmi_tx_d[4]
set_location_assignment PIN_AD10 -to hdmi_tx_d[5]
set_location_assignment PIN_AE11 -to hdmi_tx_d[6]
set_location_assignment PIN_Y5   -to hdmi_tx_d[7]
set_location_assignment PIN_AF10 -to hdmi_tx_d[8]
set_location_assignment PIN_Y4   -to hdmi_tx_d[9]
set_location_assignment PIN_AE9  -to hdmi_tx_d[10]
set_location_assignment PIN_AB4  -to hdmi_tx_d[11]
set_location_assignment PIN_AE7  -to hdmi_tx_d[12]
set_location_assignment PIN_AF6  -to hdmi_tx_d[13]
set_location_assignment PIN_AF8  -to hdmi_tx_d[14]
set_location_assignment PIN_AF5  -to hdmi_tx_d[15]
set_location_assignment PIN_AE4  -to hdmi_tx_d[16]                
set_location_assignment PIN_AH2  -to hdmi_tx_d[17]
set_location_assignment PIN_AH4  -to hdmi_tx_d[18]
set_location_assignment PIN_AH5  -to hdmi_tx_d[19]
set_location_assignment PIN_AH6  -to hdmi_tx_d[20]
set_location_assignment PIN_AG6  -to hdmi_tx_d[21]
set_location_assignment PIN_AF9  -to hdmi_tx_d[22]
set_location_assignment PIN_AE8  -to hdmi_tx_d[23]
set_location_assignment PIN_AD19 -to hdmi_tx_de
set_location_assignment PIN_T8   -to hdmi_tx_hs
set_location_assignment PIN_AF11 -to hdmi_tx_int
set_location_assignment PIN_V13  -to hdmi_tx_vs      
                                                   
# Fitter Assignments
# ==================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_MDC
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_MDIO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_RXD0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_RXD1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_RXD2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_RXD3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_RX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_RX_CTL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_TXD0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_TXD3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_TXD1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_TXD2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_TX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_emac1_TX_CTL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_qspi_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_qspi_IO0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_qspi_IO1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_qspi_IO2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_qspi_IO3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_qspi_SS0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_sdio_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_sdio_CMD
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_sdio_D0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_sdio_D1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_sdio_D2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_sdio_D3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_uart0_RX
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_uart0_TX
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_D0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_D1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_D2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_D3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_D4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_D5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_D6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_D7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_DIR
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_NXT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_usb1_STP
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_MDC
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_MDIO
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_RXD0
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_RXD1
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_RXD2
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_RXD3
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_RX_CLK
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_RX_CTL
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_TXD0
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_TXD1
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_TXD2
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_TXD3
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_TX_CLK
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_emac1_TX_CTL
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_CLK
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_D0
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_D1
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_D2
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_D3
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_D4
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_D5
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_D6
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_D7
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_DIR
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_NXT
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_usb1_STP
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_qspi_CLK
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_qspi_IO0
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_qspi_IO1
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_qspi_IO2
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_qspi_IO3
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_qspi_SS0
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_sdio_CLK
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_sdio_CMD
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_sdio_D0
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_sdio_D1
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_sdio_D2
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_sdio_D3
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_uart0_RX
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_uart0_TX
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to adc_convst
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to adc_sck
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to adc_sdi
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to adc_sdo
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_io[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arduino_reset_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_clk1_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_clk2_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_clk3_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[24]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[25]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[26]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[27]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[28]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[29]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[30]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[31]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[32]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[33]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[34]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_0[35]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[24]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[25]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[26]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[27]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[28]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[29]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[30]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[31]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[32]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[33]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[34]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio_1[35]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_key_pio[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_key_pio[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_led_pio[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_led_pio[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_led_pio[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_led_pio[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_led_pio[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_led_pio[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_led_pio[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_led_pio[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_dipsw_pio[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_dipsw_pio[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_dipsw_pio[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to fpga_dipsw_pio[3]

#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_CONV_USB_N

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_spim1_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_spim1_MOSI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_spim1_SS0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_i2c0_SDA
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_i2c0_SCL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_i2c1_SDA
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_i2c1_SCL

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_gpio_GPIO09
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_gpio_GPIO35
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_gpio_GPIO40
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_gpio_GPIO53
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_gpio_GPIO54
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_gpio_GPIO61      

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_i2c_scl
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_i2c_sda
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_i2s
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_lrclk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_mclk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_sclk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[3]                 
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_d[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_de
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_hs
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_int
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hdmi_tx_vs

#set_global_assignment -name ENABLE_SIGNALTAP ON
#set_global_assignment -name USE_SIGNALTAP_FILE ../hdl_src/fft_msgdma.stp
#set_global_assignment -name SIGNALTAP_FILE ../hdl_src/fft_msgdma.stp
#set_global_assignment -name SIGNALTAP_FILE ../hdl_src/validator.stp
