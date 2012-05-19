#!/bin/sh

. ./config.sh

native

echod "Building Native binutils ${BINUTILS_VERSION}"

cd build/binutils-${BINUTILS_VERSION} || \
	die "Could not CD to build/binutils-${BINUTILS_VERSION}"

mkdir obj
cd obj

test -f config.status || {
	../configure --disable-nls --prefix=$NATIVEPREFIX --with-mpc=$NATIVEPREFIX --with-mpfr=$NATIVEPREFIX --with-gmp=$NATIVEPREFIX >$LOGS/binutils-config-native.log 2>&1 || \
		die "Could not configure BINUTILS ${BINUTILS_VERSION}"
}

make configure-host >$LOGS/binutils-configure-host-native.log 2>&1 || \
	die "Could not make configure-host for BINUTILS ${BINUTILS_VERSION}"

cd bfd
$MAKE headers >$LOGS/binutils-headers-native.log 2>&1 || \
	die "Could not build bfd headers for BINUTILS ${BINUTILS_VERSION}"
cd ..


$MAKE >$LOGS/binutils-make-native.log 2>&1 || \
	die "Could not build BINUTILS ${BINUTILS_VERSION}"

#$MAKE  check || \
#	die "BINUTILS ${BINUTILS_VERSION} tests failed"

$MAKE install >$LOGS/binutils-install-native.log 2>&1 || \
	die "Could not install ${BINUTILS_VERSION}"

cd ..

echod "Done building Native binutils ${BINUTILS_VERSION}"
