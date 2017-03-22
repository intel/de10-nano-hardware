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


################################################################################
# Quartus Targets
#############

define set_default_project_settings
	quartus_sh --no_banner --set -rev $1 PROJECT_OUTPUT_DIRECTORY=output_files $1/$1.qpf 2>&1 | tee -a logs/$$(notdir $$@).log
	quartus_sh --no_banner --set -rev $1 SMART_RECOMPILE=ON $1/$1.qpf 2>&1 | tee -a logs/$$(notdir $$@).log
	quartus_sh --no_banner --set -rev $1 TOP_LEVEL_ENTITY=$(TOP_LEVEL_ENTITY) $1/$1.qpf 2>&1 | tee -a logs/$$(notdir $$@).log
	quartus_sh --no_banner --set -rev $1 QIP_FILE=$(QSYS_BASE_NAME)/synthesis/$(QSYS_BASE_NAME).qip $1/$1.qpf 2>&1 | tee -a logs/$$(notdir $$@).log
#	quartus_sh --no_banner --set -rev $1 VERILOG_MACRO="$1=1" $1/$1.qpf 2>&1 | tee -a logs/$$(notdir $$@).log
	quartus_sh --no_banner --set -rev $1 SEARCH_PATH="../ip" $1/$1.qpf 2>&1 | tee -a logs/$$(notdir $$@).log
endef

define create_quartus_targets


#############
# Create QuartusII Project
#############

HELP_TARGETS_$1 += $1.create_project
$1.create_project.HELP := Create Quartus Project for $1
.PHONY: $1.create_project
$1.create_project: $$(CREATE_PROJECT_STAMP_$1)

$$(QUARTUS_QPF_$1): $$(CREATE_PROJECT_STAMP_$1)

$$(CREATE_PROJECT_STAMP_$1): $$(CREATE_PROJECT_DEPS_$1) 
	@$(RM) $1
	@$(MKDIR) $1
	quartus_sh --no_banner -t $$(SCRIPT_DIR)/create_project.tcl $1 -d $1 -c $1 2>&1 | tee logs/$$(notdir $$@).log
	quartus_sh --no_banner -t $$(SCRIPT_DIR)/create_revision.tcl $1/$1.qpf -new $1 2>&1 | tee -a logs/$$(notdir $$@).log
	quartus_sh --no_banner -t $$(SCRIPT_DIR)/project_run_script.tcl $1/$1.qpf -c $1 -script $(CURDIR)/$$< 2>&1 | tee -a logs/$$(notdir $$@).log
	$(call set_default_project_settings,$1)
	$(MAKE) $1/addon_components.ipx
	$$(stamp_target)

$1/hps_isw_handoff: $$(QUARTUS_STAMP_$1)

$1/$1.qsf: $$(CREATE_PROJECT_STAMP_$1)

#############
# target for compilation
#############

HELP_TARGETS_$1 += $1.quartus_compile
$1.quartus_compile.HELP := Compile Quartus Project Revision $1

.PHONY: $1.quartus_compile
$1.quartus_compile: $$(QUARTUS_STAMP_$1)

$$(QUARTUS_SOF_$1): $$(QUARTUS_STAMP_$1)

$$(QUARTUS_JDI_$1): $$(QUARTUS_STAMP_$1)

$$(QUARTUS_STAMP_$1): $$(QUARTUS_DEPS_$1)
	quartus_stp $$(QUARTUS_QPF_$1) -c $1 2>&1 | tee logs/$$(notdir $$@).log
	quartus_sh --flow compile $$(QUARTUS_QPF_$1) -c $1 2>&1 | tee -a logs/$$(notdir $$@).log
	$$(stamp_target)	
	
#
# This converts the sof into compressed, unencrypted 
# raw binary format corresponding to MSEL value of 8 
# in the FPGAMGRREGS_STAT register. If you read the 
# the whole register, it should be 0x50.
#
# CVSoC DevBoard SW1 MSEL should be set to up,down,up,down,up,up
#

QUARTUS_CPF_ARGS = bitstream_compression=on

$$(QUARTUS_RBF_$1): %.rbf: %.sof
	$(ECHO) $$(QUARTUS_RBF_$1)
	quartus_cpf -c -o bitstream_compression=on $$< $$@ 2>&1 | tee logs/$$(notdir $$@).log


HELP_TARGETS_$1 += $1.quartus_edit
$1.quartus_edit.HELP := Launch Quartus II GUI for $1

.PHONY: $1.quartus_edit
$1.quartus_edit: $$(CREATE_PROJECT_STAMP_$1)
	quartus $$(QUARTUS_QPF_$1) &
	
endef

$(foreach r,$(REVISION_LIST),$(eval $(call create_quartus_targets,$r)))



################################################################################

