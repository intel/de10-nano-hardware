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


# 
# FFT_STadapter "FFT_STadapter" v1.0
#  2015.02.18.16:26:34
# 
# 

# 
# request TCL package from ACDS 14.1
# 
package require -exact qsys 14.1


# 
# module FFT_STadapter
# 
set_module_property DESCRIPTION ""
set_module_property NAME FFT_STadapter
set_module_property VERSION 1.1
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME FFT_STadapter
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property ELABORATION_CALLBACK elaborate


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL fft_adapter
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file fft_adapter.v VERILOG PATH fft_adapter.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL fft_adapter
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file fft_adapter.v VERILOG PATH fft_adapter.v


# 
# parameters
# 
add_parameter FFT_IN_WIDTH INTEGER 16
set_parameter_property FFT_IN_WIDTH DEFAULT_VALUE 16
set_parameter_property FFT_IN_WIDTH DISPLAY_NAME FFT_IN_WIDTH
set_parameter_property FFT_IN_WIDTH TYPE INTEGER
set_parameter_property FFT_IN_WIDTH UNITS None
set_parameter_property FFT_IN_WIDTH ALLOWED_RANGES 4:31
set_parameter_property FFT_IN_WIDTH HDL_PARAMETER true
set_parameter_property FFT_IN_WIDTH AFFECTS_ELABORATION true
add_parameter FFT_OUT_WIDTH INTEGER 24
set_parameter_property FFT_OUT_WIDTH DEFAULT_VALUE 24
set_parameter_property FFT_OUT_WIDTH DISPLAY_NAME FFT_OUT_WIDTH
set_parameter_property FFT_OUT_WIDTH TYPE INTEGER
set_parameter_property FFT_OUT_WIDTH UNITS None
set_parameter_property FFT_OUT_WIDTH ALLOWED_RANGES 24:32
set_parameter_property FFT_OUT_WIDTH HDL_PARAMETER true
set_parameter_property FFT_OUT_WIDTH AFFECTS_ELABORATION true
add_parameter SIZE_WIDTH INTEGER 11
set_parameter_property SIZE_WIDTH DEFAULT_VALUE 11
set_parameter_property SIZE_WIDTH DISPLAY_NAME SIZE_WIDTH
set_parameter_property SIZE_WIDTH TYPE INTEGER
set_parameter_property SIZE_WIDTH UNITS None
set_parameter_property SIZE_WIDTH ALLOWED_RANGES 4:16
set_parameter_property SIZE_WIDTH HDL_PARAMETER true
set_parameter_property SIZE_WIDTH AFFECTS_ELABORATION true


# 
# display items
# 


# 
# connection point in0
# 
add_interface in0 avalon_streaming end
set_interface_property in0 associatedClock clock
set_interface_property in0 associatedReset reset
set_interface_property in0 dataBitsPerSymbol 8
set_interface_property in0 errorDescriptor ""
set_interface_property in0 firstSymbolInHighOrderBits true
set_interface_property in0 maxChannel 0
set_interface_property in0 readyLatency 0
set_interface_property in0 ENABLED true
set_interface_property in0 EXPORT_OF ""
set_interface_property in0 PORT_NAME_MAP ""
set_interface_property in0 CMSIS_SVD_VARIABLES ""
set_interface_property in0 SVD_ADDRESS_GROUP ""

add_interface_port in0 asi_in0_ready ready Output 1
add_interface_port in0 asi_in0_valid valid Input 1
add_interface_port in0 asi_in0_startofpacket startofpacket Input 1
add_interface_port in0 asi_in0_endofpacket endofpacket Input 1
add_interface_port in0 asi_in0_error error Input 2
add_interface_port in0 asi_in0_empty empty Input 2
add_interface_port in0 asi_in0_data data Input 2*FFT_IN_WIDTH


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
# connection point out0
# 
add_interface out0 avalon_streaming start
set_interface_property out0 associatedClock clock
set_interface_property out0 associatedReset reset
set_interface_property out0 dataBitsPerSymbol 8
set_interface_property out0 errorDescriptor ""
set_interface_property out0 firstSymbolInHighOrderBits true
set_interface_property out0 maxChannel 0
set_interface_property out0 readyLatency 0
set_interface_property out0 ENABLED true
set_interface_property out0 EXPORT_OF ""
set_interface_property out0 PORT_NAME_MAP ""
set_interface_property out0 CMSIS_SVD_VARIABLES ""
set_interface_property out0 SVD_ADDRESS_GROUP ""

add_interface_port out0 aso_out0_data data Output 64
add_interface_port out0 aso_out0_ready ready Input 1
add_interface_port out0 aso_out0_valid valid Output 1
add_interface_port out0 aso_out0_startofpacket startofpacket Output 1
add_interface_port out0 aso_out0_endofpacket endofpacket Output 1
add_interface_port out0 aso_out0_error error Output 2
add_interface_port out0 aso_out0_empty empty Output 3


# 
# connection point fromfft
# 
add_interface fromfft avalon_streaming end
set_interface_property fromfft associatedClock clock
set_interface_property fromfft associatedReset reset
set_interface_property fromfft dataBitsPerSymbol 59
set_interface_property fromfft errorDescriptor ""
set_interface_property fromfft firstSymbolInHighOrderBits true
set_interface_property fromfft maxChannel 0
set_interface_property fromfft readyLatency 0
set_interface_property fromfft ENABLED true
set_interface_property fromfft EXPORT_OF ""
set_interface_property fromfft PORT_NAME_MAP ""
set_interface_property fromfft CMSIS_SVD_VARIABLES ""
set_interface_property fromfft SVD_ADDRESS_GROUP ""

add_interface_port fromfft asi_fromfft_data data Input "(2*FFT_OUT_WIDTH +SIZE_WIDTH)"
add_interface_port fromfft asi_fromfft_ready ready Output 1
add_interface_port fromfft asi_fromfft_valid valid Input 1
add_interface_port fromfft asi_fromfft_startofpacket startofpacket Input 1
add_interface_port fromfft asi_fromfft_endofpacket endofpacket Input 1
add_interface_port fromfft asi_fromfft_error error Input 2


# 
# connection point tofft
# 
add_interface tofft avalon_streaming start
set_interface_property tofft associatedClock clock
set_interface_property tofft associatedReset reset
set_interface_property tofft dataBitsPerSymbol 44
set_interface_property tofft errorDescriptor ""
set_interface_property tofft firstSymbolInHighOrderBits true
set_interface_property tofft maxChannel 0
set_interface_property tofft readyLatency 0
set_interface_property tofft ENABLED true
set_interface_property tofft EXPORT_OF ""
set_interface_property tofft PORT_NAME_MAP ""
set_interface_property tofft CMSIS_SVD_VARIABLES ""
set_interface_property tofft SVD_ADDRESS_GROUP ""

add_interface_port tofft aso_tofft_data data Output "(2*FFT_IN_WIDTH+SIZE_WIDTH) + 1"
add_interface_port tofft aso_tofft_ready ready Input 1
add_interface_port tofft aso_tofft_valid valid Output 1
add_interface_port tofft aso_tofft_startofpacket startofpacket Output 1
add_interface_port tofft aso_tofft_endofpacket endofpacket Output 1
add_interface_port tofft aso_tofft_error error Output 2


# 
# connection point s0
# 
add_interface s0 avalon end
set_interface_property s0 addressUnits WORDS
set_interface_property s0 associatedClock clock
set_interface_property s0 associatedReset reset
set_interface_property s0 bitsPerSymbol 8
set_interface_property s0 burstOnBurstBoundariesOnly false
set_interface_property s0 burstcountUnits WORDS
set_interface_property s0 explicitAddressSpan 0
set_interface_property s0 holdTime 0
set_interface_property s0 linewrapBursts false
set_interface_property s0 maximumPendingReadTransactions 0
set_interface_property s0 maximumPendingWriteTransactions 0
set_interface_property s0 readLatency 0
set_interface_property s0 readWaitTime 1
set_interface_property s0 setupTime 0
set_interface_property s0 timingUnits Cycles
set_interface_property s0 writeWaitTime 0
set_interface_property s0 ENABLED true
set_interface_property s0 EXPORT_OF ""
set_interface_property s0 PORT_NAME_MAP ""
set_interface_property s0 CMSIS_SVD_VARIABLES ""
set_interface_property s0 SVD_ADDRESS_GROUP ""

add_interface_port s0 avs_s0_address address Input 2
add_interface_port s0 avs_s0_read read Input 1
add_interface_port s0 avs_s0_readdata readdata Output 32
add_interface_port s0 avs_s0_write write Input 1
add_interface_port s0 avs_s0_writedata writedata Input 32

set_interface_assignment s0 embeddedsw.configuration.isFlash 0
set_interface_assignment s0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s0 embeddedsw.configuration.isPrintableDevice 0

# Device tree parameters
set_module_assignment embeddedsw.dts.vendor "altr"
set_module_assignment embeddedsw.dts.group "fft_stadapter"
set_module_assignment embeddedsw.dts.name "fft_stadapter"
set_module_assignment embeddedsw.dts.compatible "altr,fft_stadapter"

proc elaborate {} {
	set fft_inw [ get_parameter_value FFT_IN_WIDTH ]
	set fft_outw [ get_parameter_value FFT_OUT_WIDTH ]
	set sizew [ get_parameter_value SIZE_WIDTH ]

set_interface_property fromfft dataBitsPerSymbol [expr (2*$fft_outw +$sizew)]
set_interface_property tofft dataBitsPerSymbol [expr (2*$fft_inw+$sizew) + 1]
}
