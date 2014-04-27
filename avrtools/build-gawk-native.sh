#!/bin/sh

. ./config.sh

native gawk


echod "Building Native GAWK ${GAWK_VERSION}"

cd build/native/gawk-${GAWK_VERSION} || \
	die "Could not CD to build/GAWK-${GAWK_VERSION}"

test -f config.log || {
	./configure --prefix=$NATIVEPREFIX \
	   >$LOGS/gawk-config.log 2>&1 || \
		die "Could not configure GAWK ${GAWK_VERSION}"
}

$MAKE $MAKEFLAGS >$LOGS/gawk-make-native.log 2>&1 || \
	die "Could not build GAWK ${GAWK_VERSION}"

#$MAKE  -j 4 check || \
#	die "GAWK ${GAWK_VERSION} tests failed"

$MAKE install >$LOGS/gawk-install-native.log 2>&1 || \
	die "Could not install ${GAWK_VERSION}"

echod "Done building Native GAWK ${GAWK_VERSION}"
