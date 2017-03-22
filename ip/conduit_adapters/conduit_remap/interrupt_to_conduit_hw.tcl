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
# module conduit_remap
# 
set_module_property DESCRIPTION "Remap an interrupt interface to a conduit interface."
set_module_property NAME interrupt_to_conduit
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Reset Components/Adapters"
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME interrupt_to_conduit
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property ELABORATION_CALLBACK elaborate


# 
# file sets
# 


# 
# parameters
# 
add_parameter OUTPUT_CONDUIT_ROLE STRING
set_parameter_property OUTPUT_CONDUIT_ROLE DEFAULT_VALUE "output"
set_parameter_property OUTPUT_CONDUIT_ROLE DISPLAY_NAME "Role of output_sig conduit"
set_parameter_property OUTPUT_CONDUIT_ROLE TYPE STRING
set_parameter_property OUTPUT_CONDUIT_ROLE UNITS None
set_parameter_property OUTPUT_CONDUIT_ROLE GROUP "Output Conduit"
set_parameter_property OUTPUT_CONDUIT_ROLE DESCRIPTION "Enter the role that you want to assign the output_sig conduit output."
set_parameter_property OUTPUT_CONDUIT_ROLE HDL_PARAMETER false
set_parameter_property OUTPUT_CONDUIT_ROLE AFFECTS_VALIDATION true
set_parameter_property OUTPUT_CONDUIT_ROLE AFFECTS_ELABORATION true


# 
# display items
# 


# 
# connection point input_interrupt
# 
add_interface input_interrupt interrupt start
set_interface_property input_interrupt associatedAddressablePoint ""
set_interface_property input_interrupt irqScheme INDIVIDUAL_REQUESTS
set_interface_property input_interrupt ENABLED true
set_interface_property input_interrupt EXPORT_OF ""
set_interface_property input_interrupt PORT_NAME_MAP ""
set_interface_property input_interrupt CMSIS_SVD_VARIABLES ""
set_interface_property input_interrupt SVD_ADDRESS_GROUP ""

add_interface_port input_interrupt input_sig irq Input 1


# 
# connection point output_conduit
# 
add_interface output_conduit conduit end
set_interface_property output_conduit associatedClock ""
set_interface_property output_conduit associatedReset ""
set_interface_property output_conduit ENABLED true
set_interface_property output_conduit EXPORT_OF ""
set_interface_property output_conduit PORT_NAME_MAP ""
set_interface_property output_conduit CMSIS_SVD_VARIABLES ""
set_interface_property output_conduit SVD_ADDRESS_GROUP ""

add_interface_port output_conduit output_sig output Output 1
set_port_property output_sig DRIVEN_BY input_sig


proc elaborate {} {
	set_port_property output_sig ROLE [ get_parameter_value OUTPUT_CONDUIT_ROLE ]
}

