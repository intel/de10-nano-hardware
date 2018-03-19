# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

################################################################################


define q_lic
	@$(ECHO) "(C) 2001-2016 Intel Corporation. All rights reserved." >> $$@
	@$(ECHO) "Your use of Intel Corporation's design tools, logic functions and other" >> $$@
	@$(ECHO) "software and tools, and its AMPP partner logic functions, and any output" >> $$@
	@$(ECHO) "files any of the foregoing (including device programming or simulation" >> $$@
	@$(ECHO) "files), and any associated documentation or information are expressly subject" >> $$@
	@$(ECHO) "to the terms and conditions of the Intel Program License Subscription" >> $$@
	@$(ECHO) "Agreement, Intel MegaCore Function License Agreement, or other applicable" >> $$@
	@$(ECHO) "license agreement, including, without limitation, that your use is for the" >> $$@
	@$(ECHO) "sole purpose of programming logic devices manufactured by Intel and sold by" >> $$@
	@$(ECHO) "Intel or its authorized distributors.  Please refer to the applicable" >> $$@
	@$(ECHO) "agreement for further details." >> $$@
endef

define gen_binary_license

$$(QUARTUS_SOF_LIC_$1): $$(QUARTUS_STAMP_$1) 
	@$(RM) $$(QUARTUS_SOF_LIC_$1)
	$(q_lic) $$(QUARTUS_SOF_LIC_$1)
	
$$(QUARTUS_RBF_LIC_$1): $$(QUARTUS_STAMP_$1)
	@$(RM) $$(QUARTUS_RBF_LIC_$1)
	$(q_lic) $$(QUARTUS_RBF_LIC_$1)
	
endef

$(foreach r,$(REVISION_LIST),$(eval $(call gen_binary_license,$r)))
