#!/bin/sh

. ./config.sh

echod "Building GCC ${GCC_VERSION}"

cd build || \
	die "Could not CD to build"

test -d gcc-native || {
	mkdir gcc-native || \
		die "Could not create directory gcc-native"
}

cd gcc-native || \
	die "Could not cd to gcc-native"

GCCDIR=$BUILD/gcc-${GCC_VERSION}

test -f config.log || {
	case `uname` in
		Darwin)
			../gcc-${GCC_VERSION}/configure --prefix=$LIBPREFIX \
			       --enable-languages=c \
			       --enable-lto \
			       --with-gmp=$LIBPREFIX --with-mpfr=$LIBPREFIX --with-mpc=$LIBPREFIX \
			       --disable-libssp >$LOGS/gcc-config-native.log 2>&1 || \
					die "Could not configure GCC ${GCC_VERSION}"
			;;
		Linux)
			export CFLAGS="-fvisibility=hidden"
			../gcc-${GCC_VERSION}/configure --prefix=$LIBPREFIX \
			       --enable-languages=c \
			       --enable-lto \
			       --with-gmp=$LIBPREFIX --with-mpfr=$LIBPREFIX --with-mpc=$LIBPREFIX \
			       --disable-libssp >$LOGS/gcc-config-native.log 2>&1 || \
					die "Could not configure GCC ${GCC_VERSION}"
			;;
		*)
			export PATH="`pwd`:$PATH"
			../gcc-${GCC_VERSION}/configure --prefix=$LIBPREFIX --host=i686-pc-mingw32 \
			       --enable-languages=c \
			       --enable-lto \
			       --with-gmp=$LIBPREFIX --with-mpfr=$LIBPREFIX --with-mpc=$LIBPREFIX \
			       --disable-libssp >$LOGS/gcc-config-native.log 2>&1 || \
					die "Could not configure GCC ${GCC_VERSION}"
			;;
	esac
}

$MAKE $MAKEFLAGS >$LOGS/gcc-make-native.log 2>&1 || \
	die "Could not build GCC ${GCC_VERSION}"

#$MAKE check >$LOGS/gcc-native-check.log 2>&1 || \
#	die "GCC ${GCC_VERSION} tests failed"

$MAKE install >$LOGS/gcc-install-native.log 2>&1 || \
	die "Could not install ${GCC_VERSION}"

case `uname` in
	Darwin)
		;;
	Linux)
		;;
	*)
		cp /mingw/bin/libiconv-2.dll $PREFIX/bin
		cp /mingw/bin/libintl-8.dll $PREFIX/bin
				;;
esac

cd $GCCDIR
for file in COPYING*; do
	cp $file $PREFIX/licenses/$file.gcc
done

echod "Done building GCC ${GCC_VERSION}"
