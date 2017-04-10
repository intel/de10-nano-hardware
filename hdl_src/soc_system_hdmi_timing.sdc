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

# create PLL output clocks, 148.5MHz and 60MHz
 
# 148MHz VCO
create_generated_clock \
	-add \
	-name {vco_for_148} \
	-source [get_pins {soc_inst|pll_stream|altera_pll_i|cyclonev_pll|fpll_0|fpll|refclkin}] \
	-multiply_by 4563 \
	-divide_by 512 \
	-master_clock {fpga_clk1_50} \
	[get_pins {soc_inst|pll_stream|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]}]

# 60MHz VCO
create_generated_clock \
	-add \
	-name {vco_for_60} \
	-source [get_pins {soc_inst|pll_stream|altera_pll_i|cyclonev_pll|fpll_0|fpll|refclkin}] \
	-multiply_by 2151 \
	-divide_by 256 \
	-master_clock {fpga_clk1_50} \
	[get_pins {soc_inst|pll_stream|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]}]

# Create PLL output based off 148MHz VCO
create_generated_clock \
	-add \
	-name {pll_clk_148} \
	-source [get_pins {soc_inst|pll_stream|altera_pll_i|cyclonev_pll|counter[0].output_counter|vco0ph[0]}] \
	-multiply_by 1 \
	-divide_by 3 \
	-master_clock {vco_for_148} \
	[get_pins {soc_inst|pll_stream|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]

# Create PLL output based off 60MHz VCO
create_generated_clock \
	-add \
	-name {pll_clk_60} \
	-source [get_pins {soc_inst|pll_stream|altera_pll_i|cyclonev_pll|counter[0].output_counter|vco0ph[0]}] \
	-multiply_by 1 \
	-divide_by 7 \
	-master_clock {vco_for_60} \
	[get_pins {soc_inst|pll_stream|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]

# Cut paths between two clocks on the same PLL output tap
set_clock_groups \
	-exclusive \
	-group [get_clocks {pll_clk_148}] \
	-group [get_clocks {pll_clk_60}]

derive_clock_uncertainty

#**************************************************************
# Create HDMI and I2C clocks
#**************************************************************
set HDMI_CLK {soc_inst|pll_stream|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}
create_generated_clock -add -name {hdmi_tx_clk148} -master_clock {pll_clk_148} -source [get_pins ${HDMI_CLK}] [get_ports hdmi_tx_clk]
create_clock -period "1 MHz" [get_ports hdmi_i2c_scl]

set_clock_groups -exclusive -group {pll_clk_60} -group {hdmi_tx_clk148}

# I2C IO
set_input_delay  -clock [get_clocks {hdmi_i2c_scl}] 10 [get_ports {hdmi_i2c_sda}]
set_output_delay -clock [get_clocks {hdmi_i2c_scl}] 10 [get_ports {hdmi_i2c_sda}]

# Video IO
set HDMI_CLK_PERIOD [get_clock_info -period [get_clocks hdmi_tx_clk148]]
set HDMI_TSU 1.0
set HDMI_TH  0.7
set HDMI_PAD 0.3
set HDMI_MAX [expr ${HDMI_CLK_PERIOD} - ${HDMI_TSU} - ${HDMI_PAD}]
set HDMI_MIN [expr ${HDMI_CLK_PERIOD} + ${HDMI_TH}  + ${HDMI_PAD}]

post_message -type info [format "HDMI_MAX = %f" ${HDMI_MAX}]
post_message -type info [format "HDMI_MIN = %f" ${HDMI_MIN}]

set_output_delay -clock [get_clocks hdmi_tx_clk148] -max ${HDMI_MAX} [get_ports {hdmi_tx_d[*]}]
set_output_delay -clock [get_clocks hdmi_tx_clk148] -min ${HDMI_MIN} [get_ports {hdmi_tx_d[*]}]

set_output_delay -clock [get_clocks hdmi_tx_clk148] -max ${HDMI_MAX} [get_ports {hdmi_tx_de}]
set_output_delay -clock [get_clocks hdmi_tx_clk148] -min ${HDMI_MIN} [get_ports {hdmi_tx_de}]

set_output_delay -clock [get_clocks hdmi_tx_clk148] -max ${HDMI_MAX} [get_ports {hdmi_tx_hs}]
set_output_delay -clock [get_clocks hdmi_tx_clk148] -min ${HDMI_MIN} [get_ports {hdmi_tx_hs}]

set_output_delay -clock [get_clocks hdmi_tx_clk148] -max ${HDMI_MAX} [get_ports {hdmi_tx_vs}]
set_output_delay -clock [get_clocks hdmi_tx_clk148] -min ${HDMI_MIN} [get_ports {hdmi_tx_vs}]

