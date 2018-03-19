# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

#!/bin/bash

# OLD STAMP STAMP=$(date -u +"%m-%d-%y_%H.%M.%S")
STAMP=$(date -u +"%Y%m%d_%H.%M.%S")
STAMP_SHORT=$(date -u +"%Y%m%d")
QUART_VER=$(head -1 $QUARTUS_ROOTDIR/version.txt)

# tag master
git tag -s -a RELEASE-$STAMP -m "Release Build:$STAMP QUARTUS:$QUART_VER"

git checkout --orphan temp-RELEASE-BUILD-$STAMP
git rm -rf --cached .

for i in de10-nano-fft de10-nano-base de10-nano-mandelbrot; do
	git add $i/hps_isw_handoff/*
	git add $i/preloader/*
	git add $i/output_files/*.rbf
        git add $i/output_files/*.sof
	git add $i/*.qpf
	git add $i/*.qsf
	git add $i/*.qsys
	git add $i/*.sopcinfo
	git add $i/*.ipx
done

git add LICENSE
git add README.md
git add Makefile

git add devicetrees/*
git add mks/*
git add scripts/*
git add utils/*

git add ip/*
git add hdl_src/*
git add patches/sopc2dts/* 


git clean -fd

find ./ > $STAMP.filelist
sed -i '/^\.\/\.git/d' $STAMP.filelist
sed -i '/^\.\/$/d' $STAMP.filelist

git add $STAMP.filelist
git commit -a -s -S -m "Build:$STAMP QUARTUS:$QUART_VER"

git tag -s -a tgz-RELEASE-BUILD-$STAMP -m "Build:$STAMP QUARTUS:$QUART_VER"
git archive --format=tar.gz --prefix=de10-nano-build_$STAMP_SHORT/ --output=de10-nano-build_$STAMP_SHORT.tgz tgz-RELEASE-BUILD-$STAMP
