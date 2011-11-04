#!/bin/sh

. config.sh

echod "Building AVR-libc ${AVRLIBC_VERSION}"

cd build/avr-libc-${AVRLIBC_VERSION} || \
	die "Could not CD to build/gmp-${AVRLIBC_VERSION}"

test -f config.status || {
	./configure --prefix=$PREFIX --host=avr >$LOGS/avrlibc-config.log 2>&1 || \
		die "Could not configure AVRLIBC ${AVRLIBC_VERSION}"
}

$MAKE -j 8 $MAKEFLAGS >$LOGS/avrlibc-make.log 2>&1 || \
	die "Could not build AVRLIBC ${AVRLIBC_VERSION}"

echod "Checking AVR-libc ${AVRLIBC_VERSION}"
$MAKE check >$LOGS/avrlibc-check.log 2>&1 || \
	die "AVRLIBC ${AVRLIBC_VERSION} tests failed"

echod "Installing AVR-libc ${AVRLIBC_VERSION}"
$MAKE install >$LOGS/avrlibc-install.log 2>&1 || \
	die "Could not install ${AVRLIBC_VERSION}"

cp LICENSE $PREFIX/licenses/LICENSE.avrlibc

echod "Done Building AVR-libc ${AVRLIBC_VERSION}"