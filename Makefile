# Copyright (c) 2016 Intel Corporation
#`SPDX-License-Identifier: MIT

################################################
#
# Makefile to Manage QuartusII/QSys Design
#
################################################

SHELL := /bin/bash

.SUFFIXES: # Delete the default suffixes
.DEFAULT_GOAL := help

include mks/default.mk

################################################
# Configuration

# Source 
TCL_SOURCE = $(wildcard scripts/*.tcl)
QUARTUS_HDL_SOURCE = $(wildcard src/*.v) $(wildcard src/*.vhd) $(wildcard src/*.sv)
QUARTUS_MISC_SOURCE = $(wildcard src/*.stp) $(wildcard src/*.sdc)
PROJECT_ASSIGN_SCRIPTS = $(filter scripts/create_quartus_%.tcl,$(TCL_SOURCE))

QSYS_ADD_COMP_TCLS := $(sort $(wildcard scripts/qsys_add_*.tcl))

# Board revisions
REVISION_LIST = $(patsubst create_quartus_%,%,$(basename $(notdir $(PROJECT_ASSIGN_SCRIPTS))))

QUARTUS_DEFAULT_REVISION_FILE = \
        $(if \
        $(filter create_quartus_$(PROJECT_NAME).tcl,$(notdir $(PROJECT_ASSIGN_SCRIPTS))), \
        create_quartus_$(PROJECT_NAME).tcl, \
        $(firstword $(PROJECT_ASSIGN_SCRIPTS)))

QUARTUS_DEFAULT_REVISION = $(patsubst create_quartus_%, \
        %, \
        $(basename $(notdir $(QUARTUS_DEFAULT_REVISION_FILE))))

SCRIPT_DIR = utils

# Project specific settings
PROJECT_NAME = soc_workshop_system
QSYS_BASE_NAME = soc_system
TOP_LEVEL_ENTITY = top

QSYS_HPS_INST_NAME = hps_0

DTS_COMMON =

# AR_FILTER_OUT := downloads

# initial save file list
AR_REGEX += ip readme.txt mks sopc2dts_overlay.xml 
AR_REGEX += scripts 
AR_REGEX += devicetree
AR_REGEX += patches
AR_REGEX += $(SCRIPT_DIR) 
AR_REGEX += hdl_src
AR_REGEX += utils

################################################
.PHONY: default
default: help
################################################

################################################
.PHONY: all
all: all-deps

################################################
# DEPS
                                                                          
define create_deps
CREATE_PROJECT_STAMP_$1 := $(call get_stamp_target,$1.create_project)

CREATE_PROJECT_DEPS_$1 := scripts/create_quartus_$1.tcl | logs

QUARTUS_STAMP_$1 := $(call get_stamp_target,$1.quartus)

QSYS_STAMP_$1 := $(call get_stamp_target,$1.qsys_compile)
QSYS_GEN_STAMP_$1 := $(call get_stamp_target,$1.qsys_gen)
QSYS_ADD_ALL_COMP_STAMP_$1 := $(call get_stamp_target,$1.qsys_add_all_comp)

PRELOADER_GEN_STAMP_$1 := $(call get_stamp_target,$1.bsp_editor_gen)

QSYS_PIN_ASSIGNMENTS_STAMP_$1 := $$(call get_stamp_target,$1.quartus_pin_assignments)

QUARTUS_DEPS_$1 += $$(QUARTUS_PROJECT_STAMP_$1) $(QUARTUS_HDL_SOURCE) $(QUARTUS_MISC_SOURCE)
QUARTUS_DEPS_$1 += $$(CREATE_PROJECT_STAMP_$1)
QUARTUS_DEPS_$1 += $$(QSYS_PIN_ASSIGNMENTS_STAMP_$1) $$(QSYS_STAMP_$1)

QSYS_GEN_DEPS_$1 += $$(CREATE_PROJECT_STAMP_$1)
QSYS_GEN_DEPS_$1 += scripts/create_qsys_$1.tcl scripts/qsys_default_components.tcl
QSYS_GEN_DEPS_$1 += $(QSYS_ADD_COMP_TCLS)
QSYS_GEN_DEPS_$1 += $1/addon_components.ipx
#QSYS_GEN_DEPS_$1 += $1/supplemental-reset-components-for-qsys.ipx

QUARTUS_QPF_$1 := $1/$1.qpf
QUARTUS_QSF_$1 := $1/$1.qsf
QUARTUS_SOF_$1 := $1/output_files/$1.sof
QUARTUS_RBF_$1 := $1/output_files/$1.rbf
QUARTUS_SOF_LIC_$1 := $1/output_files/LICENSE.$1.sof
QUARTUS_RBF_LIC_$1 := $1/output_files/LICENSE.$1.rbf
QUARTUS_JDI_$1 := $1/output_files/$1.jdi

QSYS_FILE_$1 := $1/$(QSYS_BASE_NAME).qsys
QSYS_SOPCINFO_$1 := $1/$(QSYS_BASE_NAME).sopcinfo

#QSYS_SOPCINFO_$1 := $(patsubst $1/%.qsys,$1/%.sopcinfo,$$(QSYS_FILE_$1))

DEVICE_TREE_SOURCE_$1 := devicetrees/$1.dtso
DEVICE_TREE_INCLUDE_$1 := $1.dtsi
DEVICE_TREE_BLOB_$1 := devicetrees/$1.dtbo

AR_FILES += $$(QUARTUS_RBF_$1) $$(QUARTUS_SOF_$1)	
AR_FILES += $$(QSYS_SOPCINFO_$1) $$(QSYS_FILE_$1)

AR_REGEX += $1/$(QSYS_BASE_NAME)/*.svd


ALL_DEPS_$1 += $$(QUARTUS_RBF_$1) $$(QUARTUS_SOF_$1) $$(QUARTUS_JDI_$1)
ALL_DEPS_$1 += $$(QUARTUS_RBF_LIC_$1) $$(QUARTUS_SOF_LIC_$1)
ALL_DEPS_$1 += $$(QUARTUS_JDI_$1) $$(QSYS_SOPCINFO_$1) $$(QSYS_FILE_$1)
ALL_DEPS_$1 += $1/hps_isw_handoff $1/$1.qpf $1/$1.qsf
ALL_DEPS_$1 += $$(DEVICE_TREE_SOURCE_$1)
ALL_DEPS_$1 += $$(DEVICE_TREE_BLOB_$1)
ALL_DEPS_$1 += $$(PRELOADER_GEN_STAMP_$1)
ALL_DEPS_$1 += $1.bsp_editor_gen

SD_FAT_$1 += $$(QUARTUS_RBF_$1) $$(QUARTUS_SOF_$1) $$(DEVICE_TREE_SOURCE_$1)

.PHONY:$1.all
$1.all: $$(ALL_DEPS_$1)
HELP_TARGETS += $1.all
$1.all.HELP := Build Quartus / preloader / uboot / devicetree / boot scripts for $1 board

endef
$(foreach r,$(REVISION_LIST),$(eval $(call create_deps,$r)))

include mks/qsys.mk mks/quartus.mk
include mks/bootscript.mk 
include mks/preloader_uboot.mk
include mks/sopc2dts.mk mks/devicetree.mk
include mks/dtc.mk
include mks/sof_rbf_license.mk
include mks/ip.mk

################################################


################################################

ALL_DEPS += $(foreach r,$(REVISION_LIST),$(ALL_DEPS_$r))

.PHONY:all-deps
all-deps: $(ALL_DEPS)

################################################


################################################
# Clean-up and Archive

AR_TIMESTAMP := $(if $(SOCEDS_VERSION),$(subst .,_,$(SOCEDS_VERSION))_)$(subst $(SPACE),,$(shell $(DATE) +%m%d%Y_%k%M%S))

AR_DIR := tgz
AR_FILE := $(AR_DIR)/soc_workshop_$(AR_TIMESTAMP).tar.gz

AR_FILES += $(filter-out $(AR_FILTER_OUT),$(wildcard $(AR_REGEX)))

CLEAN_FILES += $(filter-out $(AR_DIR) $(AR_FILES),$(wildcard *))

HELP_TARGETS += tgz
tgz.HELP := Create a tarball with the barebones source files that comprise this design

.PHONY: tarball tgz
tarball tgz: $(AR_FILE)

$(AR_FILE):
	@$(MKDIR) $(@D)
	@$(if $(wildcard $(@D)/*.tar.gz),$(MKDIR) $(@D)/.archive;$(MV) $(@D)/*.tar.gz $(@D)/.archive)
	@$(ECHO) "Generating $@..."
	@$(TAR) -czf $@ $(wildcard $(AR_FILES))

SCRUB_CLEAN_FILES += $(CLEAN_FILES)

HELP_TARGETS += scrub_clean
scrub_clean.HELP := Restore design to its barebones state

.PHONY: scrub scrub_clean
scrub scrub_clean:
	$(if $(strip $(wildcard $(SCRUB_CLEAN_FILES))),$(RM) $(wildcard $(SCRUB_CLEAN_FILES)),@$(ECHO) "You're already as clean as it gets!")

.PHONY: test_scrub_clean
test_scrub_clean:
	$(if $(strip $(wildcard $(SCRUB_CLEAN_FILES))),$(ECHO) $(wildcard $(SCRUB_CLEAN_FILES)),@$(ECHO) "You're already as clean as it gets!")

.PHONY: tgz_scrub_clean
tgz_scrub_clean:
	$(FIND) $(SOFTWARE_DIR) \( -name '*.o' -o -name '.depend*' -o -name '*.d' -o -name '*.dep' \) -delete || true
	$(MAKE) tgz AR_FILE=$(AR_FILE)
	$(MAKE) -s scrub_clean
	$(TAR) -xzf $(AR_FILE)

.PHONY: clean
clean:
	@$(ECHO) "Cleaning stamp files (which will trigger rebuild)"
	@$(RM) $(get_stamp_dir)
	@$(ECHO) " TIP: Use 'make scrub_clean' to get a deeper clean"

################################################


################################################

logs:
	$(MKDIR) logs

################################################
# Utils


################################################
# Help system

.PHONY: help
help: help-init help-targets help-revision-target help-fini

.PHONY: help-revisions
help-revisions: help-revisions-init help-revisions-list help-revisions-fini help-revision-target

.PHONY: help-revs
help-revs: help-revisions-init help-revisions-list help-revisions-fini help-revision-target-short


HELP_TARGETS_X := $(patsubst %,help-%,$(sort $(HELP_TARGETS)))

HELP_TARGET_REVISION_X := $(foreach r,$(REVISION_LIST),$(patsubst %,help_rev-%,$(sort $(HELP_TARGETS_$r))))

HELP_TARGET_REVISION_SHORT_X := $(sort $(patsubst $(firstword $(REVISION_LIST)).%,help_rev-REVISIONNAME.%,$(filter-out $(firstword $(REVISION_LIST)),$(HELP_TARGETS_$(firstword $(REVISION_LIST))))))

$(foreach h,$(filter-out $(firstword $(REVISION_LIST)),$(HELP_TARGETS_$(firstword $(REVISION_LIST)))),$(eval $(patsubst %-$(firstword $(REVISION_LIST)),%-REVISIONNAME,$h).HELP := $(subst $(firstword $(REVISION_LIST)),REVISIONNAME,$($h.HELP)))) 

HELP_REVISION_LIST := $(patsubst %,rev_list-%,$(sort $(REVISION_LIST)))

#cheat, put help at the end
HELP_TARGETS_X += help-help-revisions
help-revisions.HELP := Displays Revision specific Target Help

HELP_TARGETS_X += help-help-revs
help-revs.HELP := Displays Short Revision specific Target Help


HELP_TARGETS_X += help-help
help.HELP := Displays this info (i.e. the available targets)


.PHONY: $(HELP_TARGETS_X)
help-targets: $(HELP_TARGETS_X)
$(HELP_TARGETS_X): help-%:
	@$(ECHO) "*********************"
	@$(ECHO) "* Target: $*"
	@$(ECHO) "*   $($*.HELP)"

.PHONY: help-init
help-init:
	@$(ECHO) "*****************************************"
	@$(ECHO) "*                                       *"
	@$(ECHO) "* Manage QuartusII/QSys design          *"
	@$(ECHO) "*                                       *"
	@$(ECHO) "*     Copyright (c) 2014                *"
	@$(ECHO) "*     All Rights Reserved               *"
	@$(ECHO) "*                                       *"
	@$(ECHO) "*****************************************"
	@$(ECHO) ""

.PHONY: help-revisions-init
help-revisions-init:
	@$(ECHO) ""
	@$(ECHO) "*****************************************"
	@$(ECHO) "*                                       *"
	@$(ECHO) "* Revision specific Targets             *"
	@$(ECHO) "*    target-REVISIONNAME                *"
	@$(ECHO) "*                                       *"
	@$(ECHO) "*    Available Revisions:               *"
	

.PHONY: $(HELP_REVISION_LIST)
help-revisions-list: $(HELP_REVISION_LIST)
$(HELP_REVISION_LIST): rev_list-%: 
	@$(ECHO) "*    -> $*"

.PHONY: help-revisions-fini
help-revisions-fini:
	@$(ECHO) "*                                       *"
	@$(ECHO) "*****************************************"
	@$(ECHO) ""

.PHONY: $(HELP_TARGET_REVISION_X)
.PHONY: $(HELP_TARGET_REVISION_SHORT_X)
help-revision-target: $(HELP_TARGET_REVISION_X)
help-revision-target-short: $(HELP_TARGET_REVISION_SHORT_X)
$(HELP_TARGET_REVISION_X) $(HELP_TARGET_REVISION_SHORT_X): help_rev-%:
	@$(ECHO) "*********************"
	@$(ECHO) "* Target: $*"
	@$(ECHO) "*   $($*.HELP)"
	
.PHONY: help-fini
help-fini:
	@$(ECHO) "*********************"

################################################
