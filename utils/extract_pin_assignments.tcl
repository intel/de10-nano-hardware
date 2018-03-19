# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

package require cmdline

load_package project

set tlist "c.arg"
lappend tlist "#_unassigned_#"
lappend tlist "Revision to extract from"
lappend function_opts $tlist

set tlist "output.arg"
lappend tlist "#_unassigned_#"
lappend tlist "Output filename"
lappend function_opts $tlist

if { [llength $::quartus(args)] == 0 } {
	post_message -type error "Expected arguments are <project_name> -c <base revision name> -output <output file name>"
	qexit -error
}

set project_name [lindex $::quartus(args) 0]
set newargs [lreplace $::quartus(args) 0 0]
array set optshash [cmdline::getFunctionOptions newargs $function_opts]

set rev_name $optshash(c)
if {$rev_name != "#_unassigned_#"} {
	post_message -type info "Revision name is $rev_name"
} else {
	post_message -type error "Revision not set"
	qexit -error
}

if {$optshash(output) != "#_unassigned_#"} {
	set output_name $optshash(output)
	post_message -type info "New Revision name is $output_name"
} else {
	post_message -type error "Output filename not set"
	qexit -error
}

if { ![project_exists $project_name] } {
	post_message -type error "Project: $project_name does not exist" 
} else {
	post_message -type info "Opening Project: $project_name" 
	project_open $project_name -force
}

if [is_project_open] {
	set rev_match 0
	foreach revision [get_project_revisions] {
		if { "$rev_name" == "$revision" } {
			set rev_match 1
		}
	}
		
	if { $rev_match } {
		set filename $output_name
		if [file exists $filename] {
			file rename -force $filename $filename.bac	
		}
		set f [open $filename w]   
		puts -nonewline $f "######################################\n"
		puts -nonewline $f "# Automatically Created Pin Assignment\n"
		puts -nonewline $f "# \t\tPin Assignment\n"
		puts -nonewline $f "######################################\n\n"
		foreach_in_collection assignment [get_all_assignments -name LOCATION -type instance] {
			puts -nonewline $f "set_location_assignment "
			puts -nonewline $f "[get_assignment_info $assignment -value] "
			puts -nonewline $f "-to [get_assignment_info $assignment -to] "
			puts -nonewline $f "-tag __pin_assignment_script"
			puts -nonewline $f "\n"
		}
		
		puts -nonewline $f "\n\n"
		puts -nonewline $f "# \t\tIO Standard Assignment\n"
		foreach_in_collection assignment [get_all_assignments -name IO_STANDARD -type instance] {
			puts -nonewline $f "set_instance_assignment "
			puts -nonewline $f "-name [get_assignment_info $assignment -name] "
			puts -nonewline $f "\"[get_assignment_info $assignment -value]\" "
			puts -nonewline $f "-to [get_assignment_info $assignment -to] "
			puts -nonewline $f "-tag __pin_assignment_script"
			puts -nonewline $f "\n"
		}
		puts -nonewline $f "\n"
		close $f
		
	} else {
		post_message -type error "Project: $project_name does not have revision $rev_name"	
	}
	
	project_close

} else {
	post_message -type error "Cannot open project $project_name"
	qexit -error
}


