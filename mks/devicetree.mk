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
# Device Tree

#DTS_COMMON = sopc2dts_overlay.xml
#DTS.CLOCKINFO ?= hps_clock_info.xml
DTS.SOPC2DTS_ARGS += $(if $(DTS_COMMON),--board $(DTS_COMMON))
DTS.SOPC2DTS_ARGS += --bridge-removal all
DTS.SOPC2DTS_ARGS += --bridge-ranges bridge
DTS.SOPC2DTS_ARGS += --clocks
DTS.SOPC2DTS_ARGS += --overlay-target "/soc/base-fpga-region"
DTS.SOPC2DTS_ARGS += --pov hps_0_bridges 
DTS.SOPC2DTS_ARGS += --pov-type overlay
DTS.SOPC2DTS_ARGS += --type dts


# $(DTS.SOPC2DTS) --input $$(QSYS_SOPCINFO_$1) --output $$(DEVICE_TREE_SOURCE_$1) --firmware-name $1.rbf $$(DTS.SOPC2DTS_ARGS_$1) 2>&1 | tee logs/$$(notdir $$@).log

define build_dts_revisions

DTS.SOPC2DTS_ARGS_$1 += $(DTS.SOPC2DTS_ARGS)
#DTS.SOPC2DTS_ARGS_$1 += $(if $$(DTS_BOARDINFO_$1),--board $$(DTS_BOARDINFO_$1))

$$(DEVICE_TREE_SOURCE_$1): $$(QSYS_SOPCINFO_$1) sopc2dts.build
	$(DTS.SOPC2DTS) --input $$(QSYS_SOPCINFO_$1) --output $$(DEVICE_TREE_SOURCE_$1) $$(DTS.SOPC2DTS_ARGS_$1) 2>&1 | tee logs/$$(notdir $$@).log
	sed -i 's/hps_0_arm_gic_0/intc/g' $$(DEVICE_TREE_SOURCE_$1)
	sed -i 's/h2f_user0_clock/cfg_h2f_usr0_clk/g' $$(DEVICE_TREE_SOURCE_$1)
	sed -i 's/h2f_user1_clock/h2f_usr1_clk/g' $$(DEVICE_TREE_SOURCE_$1)
	sed -i '/dts-v1/a \/include\/ "$$(DEVICE_TREE_INCLUDE_$1)"' $$(DEVICE_TREE_SOURCE_$1)
	sed -i '/dts-v1/a \/plugin\/\;' $$(DEVICE_TREE_SOURCE_$1)
	sed -i 's/\/dts-v1\/ \/plugin\/\;/\/dts-v1\/\;/' $$(DEVICE_TREE_SOURCE_$1)

#HELP_TARGETS_$1 += $$(DEVICE_TREE_SOURCE_$1)
#$$(DEVICE_TREE_SOURCE_$1).HELP := Generate a device tree for $1

$$(DEVICE_TREE_BLOB_$1): $$(DEVICE_TREE_SOURCE_$1) devicetrees/$$(DEVICE_TREE_INCLUDE_$1) dtc.build
	$(DTS.DTC) -@ -I dts -O dtb -o $$(DEVICE_TREE_BLOB_$1) $$(DEVICE_TREE_SOURCE_$1)

endef # build_dts_revisions

$(foreach r, $(REVISION_LIST), $(eval $(call build_dts_revisions,$r)))

