#!/bin/sh

. ./config.sh

echod "Building Native MPC ${MPC_VERSION}"

cd build/mpc-${MPC_VERSION} || \
	die "Could not CD to build/mpc-${MPC_VERSION}"

test -f config.log || {
	./configure --prefix=$LIBPREFIX --enable-static --disable-shared \
	--with-mpfr-include=$LIBPREFIX/include \
	--with-gmp-include=$LIBPREFIX/include >$LOGS/mpc-config.log 2>&1 || \
		die "Could not configure MPC ${MPC_VERSION}"
}

$MAKE $MAKEFLAGS >$LOGS/mpc-make.log 2>&1 || \
	die "Could not build MPC ${MPC_VERSION}"


#$MAKE check || \
#	die "MPC ${MPC_VERSION} tests failed"

$MAKE install >$LOGS/mpc-install.log 2>&1 || \
	die "Could not install ${MPC_VERSION}"

echod "Done building MPC ${MPC_VERSION}"
