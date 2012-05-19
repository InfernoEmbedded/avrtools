#!/bin/sh

. ./config.sh

native


echod "Building Native MPC ${MPC_VERSION}"

cd build/mpc-${MPC_VERSION} || \
	die "Could not CD to build/mpc-${MPC_VERSION}"

test -f config.log || {
	./configure --prefix=$NATIVEPREFIX --enable-static --disable-shared \
	--with-mpfr-include=$NATIVEPREFIX/include \
	--with-gmp-include=$NATIVEPREFIX/include >$LOGS/mpc-config.log 2>&1 || \
		die "Could not configure MPC ${MPC_VERSION}"
}

$MAKE $MAKEFLAGS >$LOGS/mpc-native-make.log 2>&1 || \
	die "Could not build MPC ${MPC_VERSION}"


#$MAKE check || \
#	die "MPC ${MPC_VERSION} tests failed"

$MAKE install >$LOGS/mpc-native-install.log 2>&1 || \
	die "Could not install ${MPC_VERSION}"

$MAKE distclean >$LOGS/mpc-native-distclean.log 2>&1

cd ../gmp-${GMP_VERSION}

$MAKE distclean >$LOGS/gmp-distclean.log 2>&1

echod "Done building Native MPC ${MPC_VERSION}"
