#!/bin/sh

. ./config.sh

bootstrap libelf

echod "Building LibELF ${LIBELF_VERSION}"

cd build/libelf-${LIBELF_VERSION} || \
	die "Could not CD to build/libelf-${LIBELF_VERSION}"

test -f config.log || {
	./configure --prefix=$PREFIX --enable-static --disable-shared \
	--with-mpfr-include=$LIBPREFIX/include \
	--with-gmp-include=$LIBPREFIX/include >$LOGS/mpc-config.log 2>&1 || \
		die "Could not configure libelf ${LIBELF_VERSION}"
}

$MAKE >$LOGS/libelf-make.log 2>&1 || \
	die "Could not build LibELF ${LIBELF_VERSION}"

$MAKE install >$LOGS/libelf-install.log 2>&1 || \
	die "Could not install ${LIBELF_VERSION}"

cp COPYING.LIB $PREFIX/licenses/COPYING.LIB.libelf

echod "Done building LibELF ${LIBELF_VERSION}"
