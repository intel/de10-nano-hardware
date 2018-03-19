# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

################################################

# BOOTSCRIPT_REVISION_LIST := $(filter $REVISION_LIST) 

BOOTSCRIPT_REVISION_LIST := $(REVISION_LIST)

#define build_boot_script

#HELP_TARGETS_$1 += $1.boot_script_image
#$1.boot_script_image.HELP := Make boot script image for $1

#.PHONY: $1.boot_script_image
#$1.boot_script_image: $1/u-boot.scr
#
#$1/boot.script : Makefile $$(PRELOADER_STAMP_$1)
#	@$(MKDIR) $1
#	@$(RM) $$@
#	@$(ECHO) "Generating $$@"
#	@$(ECHO) "fatload mmc 0:1 \$$$$fpgadata $$(QUARTUS_RBF_$1);" >>$$@
#	@$(ECHO) "fpga load 0 \$$$$fpgadata \$$$$filesize;" >>$$@
#	@$(ECHO) "set fdtimage $$(DEVICE_TREE_BLOB_$1);" >>$$@
#	@$(ECHO) "set rootfsimage rootfs.img;" >>$$@
#	@$(ECHO) "run bridge_enable_handoff;" >>$$@
#	@$(ECHO) "setenv mmcroot /dev/ram;;" >>$$@
#	@$(ECHO) "setenv mmcload '\$$$${mmcloadcmd} mmc 0:\$$$${mmcloadpart} \$$$${loadaddr} \$$$${bootimage}; \$$$${mmcloadcmd} mmc 0:\$$$${mmcloadpart} \$$$${fdtaddr} \$$$${fdtimage}; \$$$${mmcloadcmd} mmc 0:\$$$${mmcloadpart} \$$$${fpgadata} \$$$${rootfsimage}';" >>$$@
#	@$(ECHO) "setenv mmcboot 'setenv bootargs console=ttyS0,115200 root=\$$$${mmcroot} rw rootwait; bootz \$$$${loadaddr} \$$$${fpgadata} \$$$${fdtaddr}';" >>$$@
#	@$(ECHO) "run mmcload;" >>$$@
#	@$(ECHO) "run mmcboot;" >>$$@

#$1/u-boot.scr: $1/boot.script
#	$$(UBOOT_MKIMAGE_$1) -A arm -O linux -T script -C none -a 0 -e 0 -n "bootscript" -d $1/boot.script $1/u-boot.scr


#$$(UBOOT_MKIMAGE_$1): $$(PRELOADER_STAMP_$1)

#AR_FILES += $$(UBOOT_MKIMAGE_$1)
#AR_FILES += $1/u-boot.scr: $1/boot.script

#endef # build_boot_script


#$(foreach r, $(BOOTSCRIPT_REVISION_LIST), $(eval $(call build_boot_script,$r)))

u-boot.scr: boot.script
	$(MKIMAGE) -A arm -O linux -T script -C none -a 0 -e 0 -n "bootscript" -d $< $@
