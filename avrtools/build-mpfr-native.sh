#!/bin/sh

. ./config.sh

native mpfr

echod "Building Native MPFR ${MPFR_VERSION}"

cd build/native/mpfr-${MPFR_VERSION} || \
	die "Could not CD to build/mpfr-${MPFR_VERSION}"

test -f config.log || {
	./configure --prefix=$NATIVEPREFIX --with-gmp-build=$BUILD/native/gmp-${GMP_VERSION} \
	   --enable-static --disable-shared >$LOGS/mpfr-config-native.log 2>&1 || \
		die "Could not configure MPFR ${MPFR_VERSION}"
}

$MAKE $MAKEFLAGS >$LOGS/mpfr-make-native.log 2>&1 || \
	die "Could not build MPFR ${MPFR_VERSION}"

#$MAKE check || \
#	die "MPFR ${MPFR_VERSION} tests failed"

$MAKE install >$LOGS/mpfr-install-native.log 2>&1 || \
	die "Could not install ${MPFR_VERSION}"

echod "Done building Native MPFR ${MPFR_VERSION}"
