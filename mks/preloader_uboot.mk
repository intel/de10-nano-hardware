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


################################################
# Preloader

QSYS_HPS_INST_NAME ?= hps_0

PRELOADER_DISABLE_WATCHDOG ?= 1
ifeq ($(PRELOADER_DISABLE_WATCHDOG),1)
PRELOADER_EXTRA_ARGS += --set spl.boot.WATCHDOG_ENABLE false
endif

PRELOADER_FAT_SUPPORT ?= 1
ifeq ($(PRELOADER_FAT_SUPPORT),1)
PRELOADER_EXTRA_ARGS += --set spl.boot.FAT_SUPPORT true
endif

PRELOADER_EXTRA_ARGS += --set spl.boot.FAT_LOAD_PAYLOAD_NAME $1/u-boot.img

define bsp_editor_create_revisions

PRELOADER_DIR_$1 := $1/preloader

HELP_TARGETS_$1 += $1.bsp_editor_gen
$1.bsp_editor_gen.HELP := Generate BSP-Editor Files for $1 BSP

.PHONY: $1.bsp_editor_gen
$1.bsp_editor_gen: $$(PRELOADER_GEN_STAMP_$1)

PRELOADER_EXTRA_ARGS_$1 += $(PRELOADER_EXTRA_ARGS)

$$(PRELOADER_GEN_STAMP_$1): $$(PRELOADER_GEN_DEPS_$1)
	@$(MKDIR) $$(PRELOADER_DIR_$1)
	$(SBT.CREATE_SETTINGS) \
		--type spl \
		--bsp-dir $$(PRELOADER_DIR_$1) \
		--preloader-settings-dir \
		  "$1/hps_isw_handoff/$(QSYS_BASE_NAME)_$(QSYS_HPS_INST_NAME)" \
		--settings $$(PRELOADER_DIR_$1)/settings.bsp \
		$$(PRELOADER_EXTRA_ARGS_$1) 
	$$(stamp_target)

endef # bsp_editor_create_revisions

$(foreach r, $(REVISION_LIST), $(eval $(call bsp_editor_create_revisions,$r)))
