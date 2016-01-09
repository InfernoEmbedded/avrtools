#!/bin/sh

. ./config.sh

native gcc


echod "Building Native GCC ${GCC_VERSION}"

case `uname` in
Darwin)
	oldname=$NATIVEPREFIX/x86_64-apple-darwin*/bin/strip
	newname="$oldname.orig"

	test -e "$oldname" &&
		mv "$oldname" "$newname"
	;;
esac

cd build/native || \
	die "Could not CD to build"

test -d gcc-native || {
	mkdir gcc-native || \
		die "Could not create directory gcc-native"
}

cd gcc-native || \
	die "Could not cd to gcc-native"

GCCDIR=$BUILD/gcc-${GCC_VERSION}
CFLAGS="$CFLAGS -fPIC"


test -f config.log || {
	case `uname` in
		Darwin)
			export STRIP=/usr/bin/strip
			../../gcc-${GCC_VERSION}/configure --prefix=$NATIVEPREFIX \
			       --enable-languages=c,c++ \
			       --enable-lto \
			       --with-gmp=$NATIVEPREFIX --with-mpfr=$NATIVEPREFIX --with-mpc=$NATIVEPREFIX \
                               --with-binutils=$NATIVEPREFIX \
                               --without-ppl \
			       --disable-libssp --disable-multilib --disable-shared >$LOGS/gcc-config-native.log 2>&1 || \
					die "Could not configure Native GCC ${GCC_VERSION}"
			;;
		Linux)
			export PATH="$NATIVEPREFIX/bin:$PATH"
#			export CFLAGS="-fvisibility=hidden -fPIC"
			../../gcc-${GCC_VERSION}/configure --prefix=$NATIVEPREFIX \
			       --enable-languages=c,c++ \
			       --enable-lto \
			       --with-gmp=$NATIVEPREFIX --with-mpfr=$NATIVEPREFIX --with-mpc=$NATIVEPREFIX \
                               --with-binutils=$NATIVEPREFIX \
			       --disable-libssp --disable-multilib >$LOGS/gcc-config-native.log 2>&1 || \
					die "Could not configure Native GCC ${GCC_VERSION}"
			;;
		*)
			export PATH="$NATIVEPREFIX/bin:$PATH"
			export PATH="`pwd`:$PATH"
			../../gcc-${GCC_VERSION}/configure --prefix=$NATIVEPREFIX --host=i686-pc-mingw32 \
			       --enable-languages=c,c++ \
			       --enable-lto \
			       --with-gmp=$NATIVEPREFIX --with-mpfr=$NATIVEPREFIX --with-mpc=$NATIVEPREFIX \
                               --with-binutils=$NATIVEPREFIX \
			       --disable-libssp --disable-multilib --disable-shared >$LOGS/gcc-config-native.log 2>&1 || \
					die "Could not configure Native GCC ${GCC_VERSION}"
			;;
	esac
}

$MAKE $MAKEFLAGS >$LOGS/gcc-make-native.log 2>&1 || \
	die "Could not build Native GCC ${GCC_VERSION}"

#$MAKE check >$LOGS/gcc-native-check.log 2>&1 || \
#	die "GCC ${GCC_VERSION} tests failed"

$MAKE install >$LOGS/gcc-install-native.log 2>&1 || \
	die "Could not install Native GCC ${GCC_VERSION}"


echod "Done building Native GCC ${GCC_VERSION}"
