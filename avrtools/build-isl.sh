#!/bin/sh

. ./config.sh

bootstrap isl

echod "Building ISL ${ISL}"

cd build/isl-${ISL_VERSION} || \
	die "Could not CD to build/isl-${ISL_VERSION}"

test -f config.log || {
	./configure --prefix=$LIBPREFIX --enable-static --disable-shared \
	>$LOGS/isl-config.log 2>&1 || \
		die "Could not configure ISL ${ISL_VERSION}"
}

$MAKE $MAKEFLAGS >$LOGS/isl-make.log 2>&1 || \
	die "Could not build ISL ${ISL_VERSION}"


#$MAKE check || \
#	die "ISL ${ISL_VERSION} tests failed"

$MAKE install >$LOGS/isl-install.log 2>&1 || \
	die "Could not install ${ISL_VERSION}"

echod "Done building ISL ${ISL_VERSION}"
