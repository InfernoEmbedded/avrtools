#!/bin/sh

. config.sh

echod "Building binutils ${BINUTILS_VERSION}"

cd build/binutils-${BINUTILS_VERSION} || \
	die "Could not CD to build/binutils-${BINUTILS_VERSION}"

mkdir obj-avr
cd obj-avr

test -f config.status || {
	../configure --target=avr --disable-nls --prefix=$PREFIX --with-mpc=$PREFIX --with-mpfr=$PREFIX --with-gmp=$PREFIX >$LOGS/binutils-config.log 2>&1 || \
		die "Could not configure BINUTILS ${BINUTILS_VERSION}"
}

make configure-host >$LOGS/binutils-configure-host.log 2>&1 || \
	die "Could not make configure-host"

cd bfd
$MAKE headers >$LOGS/binutils-headers.log 2>&1 || \
	die "Could not build bfd headers"
cd ..


$MAKE >$LOGS/binutils-make.log 2>&1 || \
	die "Could not build BINUTILS ${BINUTILS_VERSION}"

#$MAKE  check || \
#	die "BINUTILS ${BINUTILS_VERSION} tests failed"

$MAKE install >$LOGS/binutils-install.log 2>&1 || \
	die "Could not install ${BINUTILS_VERSION}"

cd ..
for file in COPYING*; do
	cp $file $PREFIX/licenses/$file.binutils
done

echod "Done building binutils ${BINUTILS_VERSION}"