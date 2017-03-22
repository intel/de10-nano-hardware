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

