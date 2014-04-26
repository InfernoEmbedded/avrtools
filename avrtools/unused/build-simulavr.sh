#!/bin/sh

. config.sh

echod "Building Simulavr ${SIMULAVR_VERSION}"

cd build/simulavr || \
	die "Could not CD to build/simulavr"

./bootstrap

./configure --prefix=$PREFIX || \
	die "Could not configure SIMULAVR ${SIMULAVR_VERSION}"

$MAKE || \
	die "Could not build SIMULAVR ${SIMULAVR_VERSION}"

$MAKE check || \
	die "SIMULAVR ${SIMULAVR_VERSION} tests failed"

$MAKE install || \
	die "Could not install ${SIMULAVR_VERSION}"


