#
# Copyright (c) 2016 Intel Corporation
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
package require -exact qsys 15.1


# 
# module power_on_reset
# 
set_module_property DESCRIPTION "Create a power on reset pulse."
set_module_property NAME power_on_reset
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Reset Components"
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME power_on_reset
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property ELABORATION_CALLBACK elaborate
set_module_property VALIDATION_CALLBACK validate


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL power_on_reset
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file power_on_reset.v VERILOG PATH power_on_reset.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL power_on_reset
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file power_on_reset.v VERILOG PATH power_on_reset.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL power_on_reset
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file power_on_reset.v VERILOG PATH power_on_reset.v


# 
# parameters
# 
add_parameter POR_COUNT INTEGER
set_parameter_property POR_COUNT DEFAULT_VALUE 20
set_parameter_property POR_COUNT DISPLAY_NAME "Power On Reset Count"
set_parameter_property POR_COUNT TYPE INTEGER
set_parameter_property POR_COUNT GROUP "Power On Reset Duration"
set_parameter_property POR_COUNT UNITS Cycles
set_parameter_property POR_COUNT ALLOWED_RANGES 2:128
set_parameter_property POR_COUNT DESCRIPTION "The number of clocks from power up until this reset is released, plus one clock.  Minimum value is 2 and maximum value is 128."
set_parameter_property POR_COUNT HDL_PARAMETER true
set_parameter_property POR_COUNT AFFECTS_VALIDATION true
set_parameter_property POR_COUNT AFFECTS_ELABORATION true

add_parameter CLOCK_FREQ LONG
set_parameter_property CLOCK_FREQ DEFAULT_VALUE 0
set_parameter_property CLOCK_FREQ DISPLAY_NAME "Input clock rate"
set_parameter_property CLOCK_FREQ DESCRIPTION {Input clock rate from system.}
set_parameter_property CLOCK_FREQ UNITS None
set_parameter_property CLOCK_FREQ DERIVED true
set_parameter_property CLOCK_FREQ HDL_PARAMETER false
set_parameter_property CLOCK_FREQ VISIBLE false
set_parameter_property CLOCK_FREQ SYSTEM_INFO {CLOCK_RATE "clock"}
set_parameter_property CLOCK_FREQ AFFECTS_VALIDATION true
set_parameter_property CLOCK_FREQ AFFECTS_ELABORATION true

add_parameter DURATION_TIME FLOAT
set_parameter_property DURATION_TIME DEFAULT_VALUE "0.0"
set_parameter_property DURATION_TIME DISPLAY_NAME "Power On Reset Duration"
set_parameter_property DURATION_TIME DESCRIPTION {Calculation of the power on reset duration.  Clock input must be connected to a known frequency for calculation to appear.}
set_parameter_property DURATION_TIME UNITS Nanoseconds
set_parameter_property DURATION_TIME GROUP "Power On Reset Duration"
set_parameter_property DURATION_TIME DERIVED true
set_parameter_property DURATION_TIME HDL_PARAMETER false
set_parameter_property DURATION_TIME VISIBLE false

add_parameter DURATION_STRING STRING
set_parameter_property DURATION_STRING DEFAULT_VALUE "Unknown clock input frequency."
set_parameter_property DURATION_STRING DISPLAY_NAME "Power On Reset Duration"
set_parameter_property DURATION_STRING DESCRIPTION {Calculation of the power on reset duration.  Clock input must be connected to a known frequency for calculation to appear.}
set_parameter_property DURATION_STRING UNITS none
set_parameter_property DURATION_STRING GROUP "Power On Reset Duration"
set_parameter_property DURATION_STRING DERIVED true
set_parameter_property DURATION_STRING HDL_PARAMETER false
set_parameter_property DURATION_STRING VISIBLE false


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
add_interface reset reset start
set_interface_property reset associatedClock clock
set_interface_property reset associatedDirectReset ""
set_interface_property reset associatedResetSinks ""
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Output 1


proc elaborate {} {
	set clk_freq [ get_parameter_value CLOCK_FREQ ]
	if { $clk_freq == 0.0 } {
		set_parameter_value DURATION_TIME 0.0
		set_parameter_property DURATION_TIME VISIBLE false
		set_parameter_property DURATION_STRING VISIBLE true
	} else {
		set clk_period [ expr {1.0 / $clk_freq} ]
		set por_count [ expr {[ get_parameter_value POR_COUNT ] * 1.0} ]
		set por_period [ expr {$clk_period * $por_count} ]
		set duration [ expr {$por_period / 0.000000001} ]
		set round_duration [ expr {round($duration)} ]
		set_parameter_value DURATION_TIME $round_duration
		set_parameter_property DURATION_TIME VISIBLE true
		set_parameter_property DURATION_STRING VISIBLE false
	}
}

proc validate {} {
	set_module_assignment embeddedsw.CMacro.POR_COUNT [ get_parameter_value POR_COUNT ]
	set_module_assignment embeddedsw.CMacro.CLOCK_FREQ [ get_parameter_value CLOCK_FREQ ]
}

