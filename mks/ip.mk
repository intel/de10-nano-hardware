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
