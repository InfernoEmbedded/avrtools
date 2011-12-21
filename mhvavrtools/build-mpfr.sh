#!/bin/sh

. config.sh

echod "Building MPFR ${MPFR_VERSION}"

cd build/mpfr-${MPFR_VERSION} || \
	die "Could not CD to build/mpfr-${MPFR_VERSION}"

test -f config.log || {
	./configure --prefix=$LIBPREFIX --with-gmp-build=$BUILD/gmp-${GMP_VERSION} \
	   --enable-static >$LOGS/mpfr-config.log 2>&1 || \
		die "Could not configure MPFR ${MPFR_VERSION}"
}

$MAKE $MAKEFLAGS >$LOGS/mpfr-make.log 2>&1 || \
	die "Could not build MPFR ${MPFR_VERSION}"

#$MAKE check || \
#	die "MPFR ${MPFR_VERSION} tests failed"

$MAKE install >$LOGS/mpfr-install.log 2>&1 || \
	die "Could not install ${MPFR_VERSION}"

for file in COPYING*; do
	cp $file $PREFIX/licenses/$file.mpfr
done

echod "Done building MPFR ${MPFR_VERSION}"
