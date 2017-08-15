#
# Copyright (c) 2017 Intel Corporation
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
#

package require -exact qsys 16.1


# 
# module mandelbrot_colorizer
# 
set_module_property DESCRIPTION ""
set_module_property NAME mandelbrot_colorizer
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME mandelbrot_colorizer
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL mandelbrot_colorizer
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file mandelbrot_colorizer.v VERILOG PATH mandelbrot_colorizer.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL mandelbrot_colorizer
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file mandelbrot_colorizer.v VERILOG PATH mandelbrot_colorizer.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point sl
# 
add_interface sl avalon end
set_interface_property sl addressUnits WORDS
set_interface_property sl associatedClock clock
set_interface_property sl associatedReset reset
set_interface_property sl bitsPerSymbol 8
set_interface_property sl burstOnBurstBoundariesOnly false
set_interface_property sl burstcountUnits WORDS
set_interface_property sl explicitAddressSpan 0
set_interface_property sl holdTime 0
set_interface_property sl linewrapBursts false
set_interface_property sl maximumPendingReadTransactions 0
set_interface_property sl maximumPendingWriteTransactions 0
set_interface_property sl readLatency 0
set_interface_property sl readWaitTime 1
set_interface_property sl setupTime 0
set_interface_property sl timingUnits Cycles
set_interface_property sl writeWaitTime 0
set_interface_property sl ENABLED true
set_interface_property sl EXPORT_OF ""
set_interface_property sl PORT_NAME_MAP ""
set_interface_property sl CMSIS_SVD_VARIABLES ""
set_interface_property sl SVD_ADDRESS_GROUP ""

add_interface_port sl sl_read read Input 1
add_interface_port sl sl_write write Input 1
add_interface_port sl sl_byteenable byteenable Input 4
add_interface_port sl sl_writedata writedata Input 32
add_interface_port sl sl_readdata readdata Output 32
add_interface_port sl sl_waitrequest waitrequest Output 1
set_interface_assignment sl embeddedsw.configuration.isFlash 0
set_interface_assignment sl embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment sl embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment sl embeddedsw.configuration.isPrintableDevice 0


# 
# connection point in_pixel
# 
add_interface in_pixel avalon_streaming end
set_interface_property in_pixel associatedClock clock
set_interface_property in_pixel associatedReset reset
set_interface_property in_pixel dataBitsPerSymbol 8
set_interface_property in_pixel errorDescriptor ""
set_interface_property in_pixel firstSymbolInHighOrderBits true
set_interface_property in_pixel maxChannel 0
set_interface_property in_pixel readyLatency 0
set_interface_property in_pixel ENABLED true
set_interface_property in_pixel EXPORT_OF ""
set_interface_property in_pixel PORT_NAME_MAP ""
set_interface_property in_pixel CMSIS_SVD_VARIABLES ""
set_interface_property in_pixel SVD_ADDRESS_GROUP ""

add_interface_port in_pixel in_pixel_snk_data data Input 32
add_interface_port in_pixel in_pixel_snk_ready ready Output 1
add_interface_port in_pixel in_pixel_snk_valid valid Input 1


# 
# connection point out_pixel
# 
add_interface out_pixel avalon_streaming start
set_interface_property out_pixel associatedClock clock
set_interface_property out_pixel associatedReset reset
set_interface_property out_pixel dataBitsPerSymbol 8
set_interface_property out_pixel errorDescriptor ""
set_interface_property out_pixel firstSymbolInHighOrderBits true
set_interface_property out_pixel maxChannel 0
set_interface_property out_pixel readyLatency 0
set_interface_property out_pixel ENABLED true
set_interface_property out_pixel EXPORT_OF ""
set_interface_property out_pixel PORT_NAME_MAP ""
set_interface_property out_pixel CMSIS_SVD_VARIABLES ""
set_interface_property out_pixel SVD_ADDRESS_GROUP ""

add_interface_port out_pixel out_pixel_src_data data Output 32
add_interface_port out_pixel out_pixel_src_ready ready Input 1
add_interface_port out_pixel out_pixel_src_valid valid Output 1

