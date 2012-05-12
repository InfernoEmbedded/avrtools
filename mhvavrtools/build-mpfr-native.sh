#!/bin/sh

. ./config.sh

echod "Building MPFR ${MPFR_VERSION}"

cd build/mpfr-${MPFR_VERSION} || \
	die "Could not CD to build/mpfr-${MPFR_VERSION}"

test -f config.log || {
	./configure --prefix=$LIBPREFIX --with-gmp-build=$BUILD/gmp-${GMP_VERSION} \
	   --enable-static --disable-shared >$LOGS/mpfr-config-native.log 2>&1 || \
		die "Could not configure MPFR ${MPFR_VERSION}"
}

$MAKE $MAKEFLAGS >$LOGS/mpfr-make-native.log 2>&1 || \
	die "Could not build MPFR ${MPFR_VERSION}"

#$MAKE check || \
#	die "MPFR ${MPFR_VERSION} tests failed"

$MAKE install >$LOGS/mpfr-install-native.log 2>&1 || \
	die "Could not install ${MPFR_VERSION}"

$MAKE distclean >$LOGS/mpfr-distclean-native.log 2>&1

cd ../gmp-${GMP-VERSION}
$MAKE distclean >$LOGS/gmp-distclean-native.log 2>&1

echod "Done building MPFR ${MPFR_VERSION}"
