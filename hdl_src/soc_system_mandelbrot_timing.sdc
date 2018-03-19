# Copyright (c) 2017 Intel Corporation
# SPDX-License-Identifier: MIT

# create PLL output clock, 70MHz

# 70MHz VCO
create_generated_clock \
	-add \
	-name {vco_for_70} \
	-source [get_pins {soc_inst|pll_70m|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] \
	-multiply_by 14 \
	-divide_by 2 \
	-master_clock {fpga_clk1_50} \
	[get_pins {soc_inst|pll_70m|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}]

# Create PLL output based off 70MHz VCO
create_generated_clock \
	-add \
	-name {pll_clk_70} \
	-source [get_pins {soc_inst|pll_70m|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] \
	-multiply_by 1 \
	-divide_by 5 \
	-master_clock {vco_for_70} \
	[get_pins {soc_inst|pll_70m|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]

