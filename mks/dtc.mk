# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

DTC_REPO_HASH := 0931cea3ba20d41013284c20b5a204dca002c058
DTC_REPO := "http://git.kernel.org/pub/scm/utils/dtc/dtc.git"

.PHONY: dtc.get
dtc.get: downloads/dtc_$(DTC_REPO_HASH).tgz
downloads/dtc_$(DTC_REPO_HASH).tgz:
	$(RM) dtc dtc_temp
	$(MKDIR) downloads
	git clone $(DTC_REPO) dtc_temp
	git -C dtc_temp checkout -b temp_v1.4.2 $(DTC_REPO_HASH)
	git -C dtc_temp archive --format=tar.gz --output ../downloads/dtc_$(DTC_REPO_HASH).tgz --prefix=dtc/ temp_v1.4.2
	$(RM) dtc_temp

.PHONY: dtc.extract
dtc.extract: $(call get_stamp_target,dtc.extract)
$(call get_stamp_target,dtc.extract): downloads/dtc_$(DTC_REPO_HASH).tgz
	$(RM) dtc dtc_temp
	$(MKDIR) dtc
	$(TAR) -xvzf downloads/dtc_$(DTC_REPO_HASH).tgz --strip-components 1 -C dtc
	$(stamp_target)
		

.PHONY: dtc.build
dtc.build: $(call get_stamp_target,dtc.build)
$(call get_stamp_target,dtc.build): $(call get_stamp_target,dtc.extract)
	$(MAKE) -C dtc
	$(stamp_target)

