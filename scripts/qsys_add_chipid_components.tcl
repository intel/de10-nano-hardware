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
