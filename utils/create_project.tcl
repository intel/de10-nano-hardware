# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

package require cmdline

load_package project

set tlist "c.arg"
lappend tlist "#_unassigned_#"
lappend tlist "Revision name"
lappend function_opts $tlist

set tlist "d.arg"
lappend tlist "#_unassigned_#"
lappend tlist "Directory"
lappend function_opts $tlist

if { [llength $::quartus(args)] == 0 } {
	post_message -type error "Expected arguments are <project_name> -base <base revision name> -new <new revision name>"
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

set dir $optshash(d)
if {$dir != "#_unassigned_#"} {
	set project_name "$dir/$project_name"	
}

if { [project_exists $project_name] } {
	post_message -type error "Project: $project_name already exists" 
} else {
	post_message -type info "Creating Project: $project_name" 
	project_new -revision $rev_name $project_name
}

if [is_project_open] {
	project_close

} else {
	post_message -type error "Cannot create project $project_name"
	qexit -error
}
