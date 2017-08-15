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
# module mandelbrot_distributor
# 
set_module_property DESCRIPTION ""
set_module_property NAME mandelbrot_distributor
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME mandelbrot_distributor
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL mandelbrot_distributor
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file mandelbrot_distributor.v VERILOG PATH mandelbrot_distributor.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL mandelbrot_distributor
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file mandelbrot_distributor.v VERILOG PATH mandelbrot_distributor.v


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
set_interface_property sl maximumPendingReadTransactions 1
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
add_interface_port sl sl_address address Input 3
add_interface_port sl sl_writedata writedata Input 32
add_interface_port sl sl_readdata readdata Output 32
add_interface_port sl sl_waitrequest waitrequest Output 1
add_interface_port sl sl_readdatavalid readdatavalid Output 1
set_interface_assignment sl embeddedsw.configuration.isFlash 0
set_interface_assignment sl embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment sl embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment sl embeddedsw.configuration.isPrintableDevice 0


# 
# connection point Interrupt
# 
add_interface Interrupt conduit end
set_interface_property Interrupt associatedClock ""
set_interface_property Interrupt associatedReset ""
set_interface_property Interrupt ENABLED true
set_interface_property Interrupt EXPORT_OF ""
set_interface_property Interrupt PORT_NAME_MAP ""
set_interface_property Interrupt CMSIS_SVD_VARIABLES ""
set_interface_property Interrupt SVD_ADDRESS_GROUP ""

add_interface_port Interrupt interrupt_out export Output 1


# 
# connection point in_vector
# 
add_interface in_vector avalon_streaming end
set_interface_property in_vector associatedClock clock
set_interface_property in_vector associatedReset reset
set_interface_property in_vector dataBitsPerSymbol 8
set_interface_property in_vector errorDescriptor ""
set_interface_property in_vector firstSymbolInHighOrderBits true
set_interface_property in_vector maxChannel 0
set_interface_property in_vector readyLatency 0
set_interface_property in_vector ENABLED true
set_interface_property in_vector EXPORT_OF ""
set_interface_property in_vector PORT_NAME_MAP ""
set_interface_property in_vector CMSIS_SVD_VARIABLES ""
set_interface_property in_vector SVD_ADDRESS_GROUP ""

add_interface_port in_vector in_vector_snk_data data Input 152
add_interface_port in_vector in_vector_snk_ready ready Output 1
add_interface_port in_vector in_vector_snk_valid valid Input 1


# 
# connection point out_vector_00
# 
add_interface out_vector_00 avalon_streaming start
set_interface_property out_vector_00 associatedClock clock
set_interface_property out_vector_00 associatedReset reset
set_interface_property out_vector_00 dataBitsPerSymbol 8
set_interface_property out_vector_00 errorDescriptor ""
set_interface_property out_vector_00 firstSymbolInHighOrderBits true
set_interface_property out_vector_00 maxChannel 0
set_interface_property out_vector_00 readyLatency 0
set_interface_property out_vector_00 ENABLED true
set_interface_property out_vector_00 EXPORT_OF ""
set_interface_property out_vector_00 PORT_NAME_MAP ""
set_interface_property out_vector_00 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_00 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_00 out_vector_00_src_data data Output 152
add_interface_port out_vector_00 out_vector_00_src_ready ready Input 1
add_interface_port out_vector_00 out_vector_00_src_valid valid Output 1


# 
# connection point out_vector_01
# 
add_interface out_vector_01 avalon_streaming start
set_interface_property out_vector_01 associatedClock clock
set_interface_property out_vector_01 associatedReset reset
set_interface_property out_vector_01 dataBitsPerSymbol 8
set_interface_property out_vector_01 errorDescriptor ""
set_interface_property out_vector_01 firstSymbolInHighOrderBits true
set_interface_property out_vector_01 maxChannel 0
set_interface_property out_vector_01 readyLatency 0
set_interface_property out_vector_01 ENABLED true
set_interface_property out_vector_01 EXPORT_OF ""
set_interface_property out_vector_01 PORT_NAME_MAP ""
set_interface_property out_vector_01 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_01 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_01 out_vector_01_src_data data Output 152
add_interface_port out_vector_01 out_vector_01_src_ready ready Input 1
add_interface_port out_vector_01 out_vector_01_src_valid valid Output 1


# 
# connection point out_vector_02
# 
add_interface out_vector_02 avalon_streaming start
set_interface_property out_vector_02 associatedClock clock
set_interface_property out_vector_02 associatedReset reset
set_interface_property out_vector_02 dataBitsPerSymbol 8
set_interface_property out_vector_02 errorDescriptor ""
set_interface_property out_vector_02 firstSymbolInHighOrderBits true
set_interface_property out_vector_02 maxChannel 0
set_interface_property out_vector_02 readyLatency 0
set_interface_property out_vector_02 ENABLED true
set_interface_property out_vector_02 EXPORT_OF ""
set_interface_property out_vector_02 PORT_NAME_MAP ""
set_interface_property out_vector_02 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_02 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_02 out_vector_02_src_data data Output 152
add_interface_port out_vector_02 out_vector_02_src_ready ready Input 1
add_interface_port out_vector_02 out_vector_02_src_valid valid Output 1


# 
# connection point out_vector_03
# 
add_interface out_vector_03 avalon_streaming start
set_interface_property out_vector_03 associatedClock clock
set_interface_property out_vector_03 associatedReset reset
set_interface_property out_vector_03 dataBitsPerSymbol 8
set_interface_property out_vector_03 errorDescriptor ""
set_interface_property out_vector_03 firstSymbolInHighOrderBits true
set_interface_property out_vector_03 maxChannel 0
set_interface_property out_vector_03 readyLatency 0
set_interface_property out_vector_03 ENABLED true
set_interface_property out_vector_03 EXPORT_OF ""
set_interface_property out_vector_03 PORT_NAME_MAP ""
set_interface_property out_vector_03 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_03 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_03 out_vector_03_src_data data Output 152
add_interface_port out_vector_03 out_vector_03_src_ready ready Input 1
add_interface_port out_vector_03 out_vector_03_src_valid valid Output 1


# 
# connection point out_vector_04
# 
add_interface out_vector_04 avalon_streaming start
set_interface_property out_vector_04 associatedClock clock
set_interface_property out_vector_04 associatedReset reset
set_interface_property out_vector_04 dataBitsPerSymbol 8
set_interface_property out_vector_04 errorDescriptor ""
set_interface_property out_vector_04 firstSymbolInHighOrderBits true
set_interface_property out_vector_04 maxChannel 0
set_interface_property out_vector_04 readyLatency 0
set_interface_property out_vector_04 ENABLED true
set_interface_property out_vector_04 EXPORT_OF ""
set_interface_property out_vector_04 PORT_NAME_MAP ""
set_interface_property out_vector_04 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_04 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_04 out_vector_04_src_data data Output 152
add_interface_port out_vector_04 out_vector_04_src_ready ready Input 1
add_interface_port out_vector_04 out_vector_04_src_valid valid Output 1


# 
# connection point out_vector_05
# 
add_interface out_vector_05 avalon_streaming start
set_interface_property out_vector_05 associatedClock clock
set_interface_property out_vector_05 associatedReset reset
set_interface_property out_vector_05 dataBitsPerSymbol 8
set_interface_property out_vector_05 errorDescriptor ""
set_interface_property out_vector_05 firstSymbolInHighOrderBits true
set_interface_property out_vector_05 maxChannel 0
set_interface_property out_vector_05 readyLatency 0
set_interface_property out_vector_05 ENABLED true
set_interface_property out_vector_05 EXPORT_OF ""
set_interface_property out_vector_05 PORT_NAME_MAP ""
set_interface_property out_vector_05 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_05 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_05 out_vector_05_src_data data Output 152
add_interface_port out_vector_05 out_vector_05_src_ready ready Input 1
add_interface_port out_vector_05 out_vector_05_src_valid valid Output 1


# 
# connection point out_vector_06
# 
add_interface out_vector_06 avalon_streaming start
set_interface_property out_vector_06 associatedClock clock
set_interface_property out_vector_06 associatedReset reset
set_interface_property out_vector_06 dataBitsPerSymbol 8
set_interface_property out_vector_06 errorDescriptor ""
set_interface_property out_vector_06 firstSymbolInHighOrderBits true
set_interface_property out_vector_06 maxChannel 0
set_interface_property out_vector_06 readyLatency 0
set_interface_property out_vector_06 ENABLED true
set_interface_property out_vector_06 EXPORT_OF ""
set_interface_property out_vector_06 PORT_NAME_MAP ""
set_interface_property out_vector_06 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_06 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_06 out_vector_06_src_data data Output 152
add_interface_port out_vector_06 out_vector_06_src_ready ready Input 1
add_interface_port out_vector_06 out_vector_06_src_valid valid Output 1


# 
# connection point out_vector_07
# 
add_interface out_vector_07 avalon_streaming start
set_interface_property out_vector_07 associatedClock clock
set_interface_property out_vector_07 associatedReset reset
set_interface_property out_vector_07 dataBitsPerSymbol 8
set_interface_property out_vector_07 errorDescriptor ""
set_interface_property out_vector_07 firstSymbolInHighOrderBits true
set_interface_property out_vector_07 maxChannel 0
set_interface_property out_vector_07 readyLatency 0
set_interface_property out_vector_07 ENABLED true
set_interface_property out_vector_07 EXPORT_OF ""
set_interface_property out_vector_07 PORT_NAME_MAP ""
set_interface_property out_vector_07 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_07 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_07 out_vector_07_src_data data Output 152
add_interface_port out_vector_07 out_vector_07_src_ready ready Input 1
add_interface_port out_vector_07 out_vector_07_src_valid valid Output 1


# 
# connection point out_vector_08
# 
add_interface out_vector_08 avalon_streaming start
set_interface_property out_vector_08 associatedClock clock
set_interface_property out_vector_08 associatedReset reset
set_interface_property out_vector_08 dataBitsPerSymbol 8
set_interface_property out_vector_08 errorDescriptor ""
set_interface_property out_vector_08 firstSymbolInHighOrderBits true
set_interface_property out_vector_08 maxChannel 0
set_interface_property out_vector_08 readyLatency 0
set_interface_property out_vector_08 ENABLED true
set_interface_property out_vector_08 EXPORT_OF ""
set_interface_property out_vector_08 PORT_NAME_MAP ""
set_interface_property out_vector_08 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_08 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_08 out_vector_08_src_data data Output 152
add_interface_port out_vector_08 out_vector_08_src_ready ready Input 1
add_interface_port out_vector_08 out_vector_08_src_valid valid Output 1


# 
# connection point out_vector_09
# 
add_interface out_vector_09 avalon_streaming start
set_interface_property out_vector_09 associatedClock clock
set_interface_property out_vector_09 associatedReset reset
set_interface_property out_vector_09 dataBitsPerSymbol 8
set_interface_property out_vector_09 errorDescriptor ""
set_interface_property out_vector_09 firstSymbolInHighOrderBits true
set_interface_property out_vector_09 maxChannel 0
set_interface_property out_vector_09 readyLatency 0
set_interface_property out_vector_09 ENABLED true
set_interface_property out_vector_09 EXPORT_OF ""
set_interface_property out_vector_09 PORT_NAME_MAP ""
set_interface_property out_vector_09 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_09 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_09 out_vector_09_src_data data Output 152
add_interface_port out_vector_09 out_vector_09_src_ready ready Input 1
add_interface_port out_vector_09 out_vector_09_src_valid valid Output 1


# 
# connection point out_vector_10
# 
add_interface out_vector_10 avalon_streaming start
set_interface_property out_vector_10 associatedClock clock
set_interface_property out_vector_10 associatedReset reset
set_interface_property out_vector_10 dataBitsPerSymbol 8
set_interface_property out_vector_10 errorDescriptor ""
set_interface_property out_vector_10 firstSymbolInHighOrderBits true
set_interface_property out_vector_10 maxChannel 0
set_interface_property out_vector_10 readyLatency 0
set_interface_property out_vector_10 ENABLED true
set_interface_property out_vector_10 EXPORT_OF ""
set_interface_property out_vector_10 PORT_NAME_MAP ""
set_interface_property out_vector_10 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_10 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_10 out_vector_10_src_data data Output 152
add_interface_port out_vector_10 out_vector_10_src_ready ready Input 1
add_interface_port out_vector_10 out_vector_10_src_valid valid Output 1


# 
# connection point out_vector_11
# 
add_interface out_vector_11 avalon_streaming start
set_interface_property out_vector_11 associatedClock clock
set_interface_property out_vector_11 associatedReset reset
set_interface_property out_vector_11 dataBitsPerSymbol 8
set_interface_property out_vector_11 errorDescriptor ""
set_interface_property out_vector_11 firstSymbolInHighOrderBits true
set_interface_property out_vector_11 maxChannel 0
set_interface_property out_vector_11 readyLatency 0
set_interface_property out_vector_11 ENABLED true
set_interface_property out_vector_11 EXPORT_OF ""
set_interface_property out_vector_11 PORT_NAME_MAP ""
set_interface_property out_vector_11 CMSIS_SVD_VARIABLES ""
set_interface_property out_vector_11 SVD_ADDRESS_GROUP ""

add_interface_port out_vector_11 out_vector_11_src_data data Output 152
add_interface_port out_vector_11 out_vector_11_src_ready ready Input 1
add_interface_port out_vector_11 out_vector_11_src_valid valid Output 1

