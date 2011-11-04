#!/bin/sh

. config.sh

echod "Building make ${MAKE_VERSION}"

cd build/make-${MAKE_VERSION} || \
	die "Could not CD to build/make-${MAKE_VERSION}"

$TOP/patches/make-build-msys.sh >$LOGS/make.log 2>&1

cp COPYING $PREFIX/licenses/COPYING.make

echod "Done building make ${MAKE_VERSION}"
