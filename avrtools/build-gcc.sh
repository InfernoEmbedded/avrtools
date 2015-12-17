#!/bin/sh

. ./config.sh

bootstrap gcc

echod "Building GCC ${GCC_VERSION}"

cd build || \
	die "Could not CD to build"

test -d gcc-obj || {
	mkdir gcc-obj || \
		die "Could not create directory gcc-obj"
}

cd gcc-obj || \
	die "Could not cd to gcc-obj"

GCCDIR=$BUILD/gcc-${GCC_VERSION}
export CFLAGS_FOR_TARGET="$AVRCFLAGS"

test -f config.log || {
	case `uname` in
		Darwin)
			../gcc-${GCC_VERSION}/configure --prefix=$PREFIX --target=avr \
			       --enable-languages=c,c++ --with-dwarf2 \
			       --enable-lto \
			        --with-avrlibc=yes \
			       --with-gmp=$LIBPREFIX --with-mpfr=$LIBPREFIX --with-mpc=$LIBPREFIX \
				--with-ppl=$LIBPREFIX --with-isl=$LIBPREFIX \
					--disable-isl-version-check $GCCCONFIGFLAGS \
			       --disable-libssp --disable-multilib >$LOGS/gcc-config.log 2>&1 || \
					die "Could not configure GCC ${GCC_VERSION}"
			;;
		Linux)
			export CFLAGS="-fvisibility=hidden"
			../gcc-${GCC_VERSION}/configure --prefix=$PREFIX --target=avr \
			       --enable-languages=c,c++ --with-dwarf2 \
			       --enable-lto \
			        --with-avrlibc=yes \
			       --with-gmp=$LIBPREFIX --with-mpfr=$LIBPREFIX --with-mpc=$LIBPREFIX \
					--with-ppl=$LIBPREFIX --with-isl=$LIBPREFIX \
					--disable-isl-version-check $GCCCONFIGFLAGS \
			       --disable-libssp --disable-multilib >$LOGS/gcc-config.log 2>&1 || \
					die "Could not configure GCC ${GCC_VERSION}"
			;;
		*)
			export PATH="`pwd`:$PATH"
#			../gcc-${GCC_VERSION}/configure --prefix=$PREFIX --host=i686-pc-mingw32 --target=avr \
			../gcc-${GCC_VERSION}/configure --prefix=$PREFIX --target=avr \
			       --enable-languages=c,c++ --with-dwarf2 \
			       -enable-win32-registry=Inferno-AVR-Tools \
				   --enable-lto \
			        --with-avrlibc=yes \
			       --with-gmp=$LIBPREFIX --with-mpfr=$LIBPREFIX --with-mpc=$LIBPREFIX \
					--with-ppl=$LIBPREFIX --with-isl=$LIBPREFIX \
					--disable-isl-version-check $GCCCONFIGFLAGS \
			       --disable-libssp --disable-multilib >$LOGS/gcc-config.log 2>&1 || \
					die "Could not configure GCC ${GCC_VERSION}"
			;;
	esac
}

$MAKE $MAKEFLAGS >$LOGS/gcc-make.log 2>&1 || \
	die "Could not build GCC ${GCC_VERSION}"

#$MAKE check >$LOGS/gcc-check.log 2>&1 || \
#	die "GCC ${GCC_VERSION} tests failed"

$MAKE install >$LOGS/gcc-install.log 2>&1 || \
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
