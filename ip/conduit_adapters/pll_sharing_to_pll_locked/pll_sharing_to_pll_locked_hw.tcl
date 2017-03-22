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
# module pll_sharing_to_pll_locked
# 
set_module_property DESCRIPTION "Breakout the pll_locked conduit from the pll_sharing conduit bundle provided by the EMIF IP core."
set_module_property NAME pll_sharing_to_pll_locked
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Reset Components/Adapters"
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME pll_sharing_to_pll_locked
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 


# 
# parameters
# 


# 
# display items
# 


# 
# connection point pll_sharing
# 
add_interface pll_sharing conduit end
set_interface_property pll_sharing associatedClock ""
set_interface_property pll_sharing associatedReset ""
set_interface_property pll_sharing ENABLED true
set_interface_property pll_sharing EXPORT_OF ""
set_interface_property pll_sharing PORT_NAME_MAP ""
set_interface_property pll_sharing CMSIS_SVD_VARIABLES ""
set_interface_property pll_sharing SVD_ADDRESS_GROUP ""

add_interface_port pll_sharing afi_phy_clk afi_phy_clk Input 1
add_interface_port pll_sharing pll_addr_cmd_clk pll_addr_cmd_clk Input 1
add_interface_port pll_sharing pll_avl_clk pll_avl_clk Input 1
add_interface_port pll_sharing pll_avl_phy_clk pll_avl_phy_clk Input 1
add_interface_port pll_sharing pll_config_clk pll_config_clk Input 1
add_interface_port pll_sharing pll_locked pll_locked Input 1
add_interface_port pll_sharing pll_mem_clk pll_mem_clk Input 1
add_interface_port pll_sharing pll_mem_phy_clk pll_mem_phy_clk Input 1
add_interface_port pll_sharing pll_write_clk pll_write_clk Input 1
add_interface_port pll_sharing pll_write_clk_pre_phy_clk pll_write_clk_pre_phy_clk Input 1


# 
# connection point pll_locked
# 
add_interface pll_locked conduit end
set_interface_property pll_locked associatedClock ""
set_interface_property pll_locked associatedReset ""
set_interface_property pll_locked ENABLED true
set_interface_property pll_locked EXPORT_OF ""
set_interface_property pll_locked PORT_NAME_MAP ""
set_interface_property pll_locked CMSIS_SVD_VARIABLES ""
set_interface_property pll_locked SVD_ADDRESS_GROUP ""

add_interface_port pll_locked pll_locked_out pll_locked Output 1
set_port_property pll_locked_out DRIVEN_BY pll_locked

