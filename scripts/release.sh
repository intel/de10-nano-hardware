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


#!/bin/bash

STAMP=$(date -u +"%m-%d-%y_%H.%M.%S")
QUART_VER=$(head -1 $QUARTUS_ROOTDIR/version.txt)

# tag master
git tag -s -a release-$STAMP -m "Release:$STAMP"

git checkout --orphan temp-RELEASE-BUILD-$STAMP
git rm -rf --cached .

for i in de0-nano de10-nano; do
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
git add devicetrees/*.dtso
git add devicetrees/*.dtbo
git add devicetrees/*.dtsi

git add ip/*
git add hdl_src/*

git add patches/sopc2dts/* 


git clean -fd

find ./ > $STAMP.filelist
sed -i '/^\.\/\.git/d' $STAMP.filelist
sed -i '/^\.\/$/d' $STAMP.filelist

git add $STAMP.filelist
git commit -a -s -S -m "Build:$STAMP QUARTUS:$QUART_VER"

git checkout -f RELEASE_BUILDS

git rm -rf .

git checkout temp-RELEASE-BUILD-$STAMP $STAMP.filelist;
for i in $(cat $STAMP.filelist); do
	git checkout temp-RELEASE-BUILD-$STAMP $i;
done

git add $STAMP.filelist
git add LICENSE
git add devicetrees/*.dtso
git add devicetrees/*.dtbo
git add devicetrees/*.dtsi

git add ip/*
git add hdl_src/*

git add patches/sopc2dts/* 

for i in de0-nano de10-nano; do
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

git commit -a -s -S -m "Build:$STAMP QUARTUS:$QUART_VER"
git tag -s -a RELEASE-BUILD-$STAMP -m "Build:$STAMP QUARTUS:$QUART_VER"

