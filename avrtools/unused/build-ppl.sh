#!/bin/sh

. config.sh

echod "Building PPL ${PPL_VERSION}"


cd build/ppl || \
	die "Could not CD to build/gmp-${PPL_VERSION}"

$PREFIX/bin/autoconf || \
	die "Autoconf failed"

./configure --prefix=$PREFIX --with-gmp=$PREFIX --enable-shared --enable-optimization --enable-check=quick || \
	die "Could not configure PPL ${PPL_VERSION}"

$MAKE || \
	die "Could not build PPL ${PPL_VERSION}"

$MAKE check || \
	die "PPL ${PPL_VERSION} tests failed"

$MAKE install || \
	die "Could not install ${PPL_VERSION}"

	
