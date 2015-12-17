#!/bin/sh

. ./config.sh

native gmp


echod "Building Native GMP ${GMP_VERSION}"

cd build/native/gmp-* || \
	die "Could not CD to build/gmp-${GMP_VERSION}"

test -f config.log || {
	./configure --prefix=$NATIVEPREFIX --enable-static \
	   >$LOGS/gmp-config.log 2>&1 || \
		die "Could not configure GMP ${GMP_VERSION}"
}

find . -name '*.lo' -exec dos2unix {} \; >$LOGS/gmp-dos2unix.log 2>&1

$MAKE $MAKEFLAGS >$LOGS/gmp-make-native.log 2>&1 || \
	die "Could not build GMP ${GMP_VERSION}"

#$MAKE  -j 4 check || \
#	die "GMP ${GMP_VERSION} tests failed"

$MAKE install >$LOGS/gmp-install-native.log 2>&1 || \
	die "Could not install ${GMP_VERSION}"

echod "Done building Native GMP ${GMP_VERSION}"
