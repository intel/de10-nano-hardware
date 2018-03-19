## Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

################################################################################
# QSys Targets
#############

# Under cygwin, ensure TMP env variable is not a cygwin style path
# before calling ip-generate
ifeq ($(IS_CYGWIN_HOST),1)
ifneq ($(shell $(WHICH) cygpath 2>/dev/null),)
SET_QSYS_GENERATE_ENV = TMP="$(shell cygpath -m "$(TMP)")"
endif
endif

define create_qsys_targets

HELP_TARGETS_$1 += $1.qsys_generate_qsys
$1.qsys_generate_qsys.HELP := Create QSys for $1 revision

.PHONY: $1.qsys_generate_qsys
$1.qsys_generate_qsys: $(sort $$(QSYS_GEN_STAMP_$1))

$$(QSYS_GEN_STAMP_$1): $$(QSYS_GEN_DEPS_$1)
	$(RM) $$(QSYS_FILE_$1)
	$(MKDIR) $1
	qsys-script --cmd="source scripts/create_qsys_$1.tcl; build_qsys $1" 2>&1 | tee logs/$$(notdir $$@).log
	$$(stamp_target)
 
HELP_TARGETS_$1 += $1.qsys_compile
$1.qsys_compile.HELP := Generate Qsys System - $1

.PHONY: $1.qsys_compile
$1.qsys_compile: $$(QSYS_STAMP_$1)

#so if qsys file changes, regenerate
$$(QSYS_FILE_$1): $$(QSYS_GEN_STAMP_$1)

$$(QSYS_STAMP_$1): $$(QSYS_FILE_$1) 
	$(SET_QSYS_GENERATE_ENV) qsys-generate  $$(QSYS_FILE_$1) --synthesis=VERILOG $(QSYS_GENERATE_ARGS)  2>&1 | tee logs/$$(notdir $$@).log
	$$(stamp_target)

HELP_TARGETS_$1 += $1.qsys_edit
$1.qsys_edit.HELP := Launch QSys GUI - $1

.PHONY: $1.qsys_edit
$1.qsys_edit: $$(QSYS_FILE_$1)
	qsys-edit $$(QSYS_FILE_$1) &
	
$$(QSYS_SOPCINFO_$1) $1/$(QSYS_BASE_NAME)/synthesis/$(QSYS_BASE_NAME).qip: $$(QSYS_STAMP_$1)	

#############
# Target for pin assignments                                                                                                   
#############	

$$(QSYS_PIN_ASSIGNMENTS_STAMP_$1): $$(QSYS_STAMP_$1) $$(CREATE_PROJECT_STAMP_$1)
	quartus_map $$(QUARTUS_QPF_$1) -c $1
	quartus_cdb --merge $$(QUARTUS_QPF_$1) -c $1
	$(MAKE) -j1 QSYS_ENABLE_PIN_ASSIGNMENTS_APPLY=1 $1.quartus_apply_tcl_pin_assignments 2>&1 | tee logs/$$(notdir $$@).log
	$$(stamp_target)

#######
# we need to recursively call this makefile to 
# apply *_pin_assignments.tcl script because the
# pin_assignment.tcl files may not exist yet 
# when makefile was originally called

ifeq ($$(QSYS_ENABLE_PIN_ASSIGNMENTS_APPLY),1)

QSYS_TCL_PIN_ASSIGNMENTS_$1 = $(wildcard $1/$(QSYS_BASE_NAME)/synthesis/submodules/*_pin_assignments.tcl)
QSYS_TCL_PIN_ASSIGNMENTS_APPLY_TARGETS_$1 = $(patsubst %,$1_quartus_apply_tcl-%,$$(QSYS_TCL_PIN_ASSIGNMENTS_$1))

.PHONY: $1.quartus_apply_tcl_pin_assignments
$1.quartus_apply_tcl_pin_assignments: $$(QSYS_TCL_PIN_ASSIGNMENTS_APPLY_TARGETS_$1)

.PHONY: $$(QSYS_TCL_PIN_ASSIGNMENTS_APPLY_TARGETS_$1)
$$(QSYS_TCL_PIN_ASSIGNMENTS_APPLY_TARGETS_$1): $1_quartus_apply_tcl-% : %
	@$(ECHO) "Applying $$<... to $(QUARTUS_QPF_$1)..."
	quartus_sh -t $(CURDIR)/$$< $(CURDIR)/$$(QUARTUS_QPF_$1) 2>&1 | tee logs/$$(notdir $$@).log

endif # QUARTUS_ENABLE_PIN_ASSIGNMENTS_APPLY == 1
######

endef

$(foreach r,$(REVISION_LIST),$(eval $(call create_qsys_targets,$r)))



