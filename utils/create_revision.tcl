# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

# BEGIN MAIN ----------------------------------------------------------------

package require cmdline

load_package project

set tlist "base.arg"
lappend tlist "#_unassigned_#"
lappend tlist "Revision on which to base the creation of the new revision"
lappend function_opts $tlist

set tlist "new.arg"
lappend tlist "#_unassigned_#"
lappend tlist "new revision name"

lappend function_opts $tlist

if { [llength $::quartus(args)] == 0 } {
	post_message -type error "Expected arguments are <project_name> -base <base revision name> -new <new revision name>"
	qexit -error
}

set project_name [lindex $::quartus(args) 0]
set newargs [lreplace $::quartus(args) 0 0]
array set optshash [cmdline::getFunctionOptions newargs $function_opts]

set base_name $optshash(base)
if {$base_name != "#_unassigned_#"} {
	post_message -type info "Base Revision name is $base_name"
} else {
	post_message -type info "Base revision not set, creating new revision"
#	qexit -error
}

if {$optshash(new) != "#_unassigned_#"} {
	set new_name $optshash(new)
	post_message -type info "New Revision name is $new_name"
} else {
	post_message -type error "New revision must be set!"
	qexit -error
}


if { ![project_exists $project_name] } {
	post_message -type error "Project: $project_name does not exist" 
} else {
	post_message -type info "Opening Project: $project_name" 
	project_open $project_name -current_revision -force
}

set revision_exists 0

if [is_project_open] {
	foreach revision [get_project_revisions] {
		if { [string equal "$new_name" "$revision"] } {
			post_message -type warning "Revision $new_name already exists"
			#qexit
			#delete_revision $new_name
			set revision_exists 1
		}
	}	
	if { $revision_exists} {
		set_current_revision -force $new_name
	} else {
		if {$base_name == "#_unassigned_#"} {
			create_revision -set_current $new_name
		} else {
			create_revision -based_on $base_name -set_current $new_name
		}
	}
	project_close

} else {
	post_message -type error "Cannot open project $project_name"
	qexit -error
}
