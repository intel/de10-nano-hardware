# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

SUP_COMPS_REPO_HASH := 533acace136065fc3f2dcbaaaee31fe4eda32e09
SUP_COMPS_SOURCE_PACKAGE := "https://github.com/01org/supplemental-reset-components-for-qsys/tarball/$(SUP_COMPS_REPO_HASH)"

PHONY: sup_comps.get
sup_comps.get: downloads/sup_comps_$(SUP_COMPS_REPO_HASH).tgz
downloads/sup_comps_$(SUP_COMPS_REPO_HASH).tgz:
	$(MKDIR) downloads
	wget -O $@ $(SUP_COMPS_SOURCE_PACKAGE)

.PHONY: sup_comps.extract
sup_comps.extract: supplemental-reset-components-for-qsys/reset_components.ipx
supplemental-reset-components-for-qsys/reset_components.ipx: downloads/sup_comps_$(SUP_COMPS_REPO_HASH).tgz
	$(MKDIR) supplemental-reset-components-for-qsys
	$(TAR) -xvzf downloads/sup_comps_$(SUP_COMPS_REPO_HASH).tgz --strip-components 1 -C supplemental-reset-components-for-qsys

define make_ipx_components

$1/addon_components.ipx:                                                        
	@$(MKDIR) $1                                                            
	@$(ECHO) "Creating IPX file"
	@$(ECHO) "<library>" > $1/addon_components.ipx
	@$(ECHO) "   <path path=\"../ip/**/*\" />" >> $1/addon_components.ipx
	@$(ECHO) "</library>" >> $1/addon_components.ipx

$1/supplemental-reset-components-for-qsys.ipx: supplemental-reset-components-for-qsys/reset_components.ipx
	$(MKDIR) $1
	ip-make-ipx --source-directory=./supplemental-reset-components-for-qsys --output=$1/supplemental-reset-components-for-qsys.ipx
	
endef

$(foreach r,$(REVISION_LIST),$(eval $(call make_ipx_components,$r)))
