#!/bin/sh

. ./config.sh

bootstrap cloog

echod "Building CLOOG ${CLOOG_VERSION}"

cd build/cloog-${CLOOG_VERSION} || \
	die "Could not CD to build/cloog-${CLOOG_VERSION}"

test -f config.log || {
	./configure --prefix=$LIBPREFIX --enable-static --disable-shared \
	>$LOGS/cloog-config.log 2>&1 || \
		die "Could not configure CLOOG ${CLOOG_VERSION}"
}

$MAKE $MAKEFLAGS >$LOGS/cloog-make.log 2>&1 || \
	die "Could not build CLOOG ${CLOOG_VERSION}"


#$MAKE check || \
#	die "CLOOG ${CLOOG_VERSION} tests failed"

$MAKE install >$LOGS/cloog-install.log 2>&1 || \
	die "Could not install ${CLOOG_VERSION}"

echod "Done building CLOOG ${CLOOG_VERSION}"
