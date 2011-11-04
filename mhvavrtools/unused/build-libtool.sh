#!/bin/sh

. config.sh

echod "Building libtool ${LIBTOOL_VERSION}"

cd build/libtool-${LIBTOOL_VERSION} || \
	die "Could not CD to build/gmp-${LIBTOOL_VERSION}"

./configure --prefix=$PREFIX  || \
	die "Could not configure LIBTOOL ${LIBTOOL_VERSION}"

$MAKE || \
	die "Could not build LIBTOOL ${LIBTOOL_VERSION}"

$MAKE check || \
	die "LIBTOOL ${LIBTOOL_VERSION} tests failed"

$MAKE install || \
	die "Could not install ${LIBTOOL_VERSION}"


