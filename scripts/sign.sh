# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

#!/bin/bash

STAMP_SHORT=$(date -u +"%Y%m%d")
SIGNFILE=/tools/signfile-lin-x64-3.2.471/SignFile

$SIGNFILE -vv -wf 0 -c DE10-Nano -u amr/dwesterg -p - -s cl \
	-cf de10-nano-build_$STAMP_SHORT.tgz.sig \
	de10-nano-build_$STAMP_SHORT.tgz

openssl pkcs7 -print_certs -inform der \
	-in de10-nano-build_$STAMP_SHORT.tgz.sig \
	> de10-nano-build_$STAMP_SHORT.tgz.pem

openssl x509 \
	-in de10-nano-build_$STAMP_SHORT.tgz.pem \
	-serial -noout

openssl smime -verify \
	-in de10-nano-build_$STAMP_SHORT.tgz.sig \
	-inform der \
	-content de10-nano-build_$STAMP_SHORT.tgz \
	-noverify de10-nano-build_$STAMP_SHORT.tgz.pem > /dev/null
