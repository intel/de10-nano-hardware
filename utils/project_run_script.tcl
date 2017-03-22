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

package require cmdline

load_package project

set tlist "c.arg"
lappend tlist "#_unassigned_#"
lappend tlist "Revision name"
lappend function_opts $tlist

set tlist "script.arg"
lappend tlist "#_unassigned_#"
lappend tlist "Script name"
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

set script_file $optshash(script)
if { $script_file == "#_unassigned_#"} {
	post_message -type error "Script file not specified"
	qexit -error
}

if { ![project_exists $project_name] } {
	post_message -type error "Project: $project_name doesn't exists" 
} else {
	post_message -type info "Opening Project: $project_name" 
	project_open $project_name -current_revision
}

if [is_project_open] {
	set rev_match 0
	foreach revision [get_project_revisions] {
		if { "$rev_name" == "$revision" } {
			set rev_match 1
		}
	}
	if { $rev_match } {
		set_current_revision $rev_name
		if [file exists $script_file] {
			source $script_file
		} else {
			post_message -type error "invalid script"
			qexit -error
		}
	} else {
		post_message -type error "Revision $rev_name doesn't exist"
		qexit -error
	}
	
	project_close

} else {
	post_message -type error "Cannot create project $project_name"
	qexit -error
}
