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




set project_file [ lindex $argv 0 ]
set board_ip [ lindex $argv 1 ]
set board_port [ lindex $argv 2 ]

puts "Loading project $project_file."
if { [ catch { set design_node [ design_load $project_file  ] } ] } {
  global errorInfo
  puts "Failed to load $project_file. $errorInfo."
  exit 1
}
array set design_markers [ marker_get_info $design_node ]

set existing_devices [ get_service_paths device ]

puts "Connecting to remote device on $board_ip:$board_port."
if { [ catch { set connection_node [ add_service tcp remote_system $board_ip $board_port ] } ] } {
  global errorInfo
  puts "Failed to connect to remote device. $errorInfo."
}

refresh_connections
get_service_paths device
if { [ catch { marker_get_info $connection_node } ] } {
  puts "System Console was unable to connect to $board_ip:$board_port successfully."
  exit 1
}

set new_devices {}
foreach device [ get_service_paths device ] {
  if { [ lsearch $existing_devices $device ] < 0 } {
    set new_devices [ lappend $new_devices $device ]
  }
}

set at_least_one_device_matches_project 0
puts "Found new devices:"
foreach device $new_devices {
  puts "\t$device"
  array set device_markers [ marker_get_info $device ]
  puts "\t value of design_markers $design_markers(DESIGN_HASH)"
  puts "\t value of device_markers $device_markers(DESIGN_HASH)"
  if { $design_markers(DESIGN_HASH) == $device_markers(DESIGN_HASH) } {
    set at_least_one_device_matches_project 1
  }
}
if { !$at_least_one_device_matches_project } {
  puts "The project $project_file didn't match any of the newly discovered devices."
  exit 1
}

puts "Remote system ready."
