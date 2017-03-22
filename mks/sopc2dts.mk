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

SOPC2DTS_REPO_HASH := 33881de096d24194c7da36da1831cbbe140e3956
SOPC2DTS_SOURCE_PACKAGE := "https://github.com/altera-opensource/sopc2dts/tarball/$(SOPC2DTS_REPO_HASH)"

SOPC2DTS_PATCHES = $(sort $(wildcard patches/sopc2dts/*.patch))

.PHONY: sopc2dts.get
sopc2dts.get: downloads/sopc2dts_$(SOPC2DTS_REPO_HASH).tgz
downloads/sopc2dts_$(SOPC2DTS_REPO_HASH).tgz:
	$(MKDIR) downloads
	wget -O $@ $(SOPC2DTS_SOURCE_PACKAGE)

.PHONY: sopc2dts.extract
sopc2dts.extract: $(call get_stamp_target,sopc2dts.$(SOPC2DTS_REPO_HASH).extract)
$(call get_stamp_target,sopc2dts.$(SOPC2DTS_REPO_HASH).extract): downloads/sopc2dts_$(SOPC2DTS_REPO_HASH).tgz $(SOPC2DTS_PATCHES)
	$(RM) sopc2dts
	$(MKDIR) sopc2dts
	$(TAR) -xvzf downloads/sopc2dts_$(SOPC2DTS_REPO_HASH).tgz --strip-components 1 -C sopc2dts
	$(stamp_target)

linux.patch: $(foreach p,$(SOPC2DTS_PATCHES),$(call get_stamp_target,sopc2dts.$(SOPC2DTS_REPO_HASH).$(notdir $p)))
define do_patch_sopc2dts
$(call get_stamp_target,sopc2dts.$(SOPC2DTS_REPO_HASH).$(notdir $p)): $(call get_stamp_target,sopc2dts.$(SOPC2DTS_REPO_HASH).extract)
	patch -d sopc2dts -p1 < $1 2>&1
	$$(stamp_target)
endef
$(foreach p,$(SOPC2DTS_PATCHES),$(eval $(call do_patch_sopc2dts,$p)))

.PHONY: sopc2dts.build
sopc2dts.build: $(call get_stamp_target,sopc2dts.$(SOPC2DTS_REPO_HASH).sopc2dts.build)
$(call get_stamp_target,sopc2dts.$(SOPC2DTS_REPO_HASH).sopc2dts.build): $(foreach p,$(SOPC2DTS_PATCHES),$(call get_stamp_target,sopc2dts.$(SOPC2DTS_REPO_HASH).$(notdir $p)))
	$(MAKE) -C sopc2dts
	$(stamp_target)
