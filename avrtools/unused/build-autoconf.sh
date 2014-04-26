#!/bin/sh

. config.sh

echod "Building Autoconf ${AUTOCONF_VERSION}"

cd build/autoconf-${AUTOCONF_VERSION} || \
	die "Could not CD to build/gmp-${AUTOCONF_VERSION}"

./configure --prefix=$PREFIX --enable-cxx --enable-shared --disable-static || \
	die "Could not configure AUTOCONF ${AUTOCONF_VERSION}"

$MAKE || \
	die "Could not build AUTOCONF ${AUTOCONF_VERSION}"

# tests take too long to run
#$MAKE  -j 4 check || \
#	die "AUTOCONF ${AUTOCONF_VERSION} tests failed"

#$MAKE install || \
#	die "Could not install ${AUTOCONF_VERSION}"


