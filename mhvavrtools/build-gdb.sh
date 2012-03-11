#!/bin/sh

. ./config.sh

echod "Building GDB ${GDB_VERSION}"

cd build/gdb-${GDB_VERSION} || \
	die "Could not CD to build/gdb-${GDB_VERSION}"

test -f config.status || {
	./configure --target=avr --prefix=$PREFIX --with-mpc=$LIBPREFIX --with-mpfr=$LIBPREFIX --with-gmp=$LIBPREFIX >$LOGS/gdb-config.log 2>&1 || \
		die "Could not configure GDB ${GDB_VERSION}"
}

make configure-host >$LOGS/gdb-configure-host.log 2>&1 || \
	die "Could not make configure-host for GDB ${GDB_VERSION}"

$MAKE >$LOGS/gdb-make.log 2>&1 || \
	die "Could not build GDB ${GDB_VERSION}"

$MAKE install >$LOGS/gdb-install.log 2>&1 || \
	die "Could not install GDB ${GDB_VERSION}"

case `uname` in
	Darwin)
		;;
	Linux)
		;;
	*)
		cp /mingw/bin/libgcc_s_dw2-1.dll $PREFIX/bin
				;;
esac

for file in COPYING*; do
	cp $file $PREFIX/licenses/$file.gdb
done

echod "Done building GDB ${GDB_VERSION}"
