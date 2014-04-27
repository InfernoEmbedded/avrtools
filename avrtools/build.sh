#!/bin/sh

. ./config.sh

mkdir $PREFIX
mkdir $PREFIX/bin
mkdir $PREFIX/licenses

mkdir $LOGS

test -d download || \
	./fetch.sh

test -d build/avrdude-${AVRDUDE_VERSION} || \
	./extract.sh

# Need this sleep here otherwise the configure for gmp fails - unable to rm test executables
sleep 5

test -e build/native/bin/gcc || (
	[ `uname` = MINGW32_NT-6.1 ] && {
		./build-coreutils.sh || \
			die "coreutils build failed"			
	}

	./build-gawk-native.sh || \
		die "gmp build failed"

	./build-gmp-native.sh || \
		die "gmp build failed"

	./build-mpfr-native.sh || \
		die "mpfr build failed"

	./build-mpc-native.sh || \
		die "mpc build failed"

	test "`uname`" = 'Darwin' || (
		./build-binutils-native.sh || \
			die "binutils build failed"
	)

	./build-gcc-native.sh || \
		die "gcc build failed"
		
	[ `uname` = MINGW32_NT-6.1 ] && {
		./build-iconv.sh || \
			die "iconv build failed"
			
		./build-gettext.sh || \
			die "gettext build failed"			
	}		
) 

(

	./build-gmp.sh || \
		die "gmp build failed"

	./build-mpfr.sh || \
		die "mpfr build failed"

	./build-mpc.sh || \
		die "mpc build failed"

	./build-binutils.sh || \
		die "binutils build failed"

	./build-isl.sh || \
		die "gcc build failed"

	./build-cloog.sh || \
		die "gcc build failed"

	./build-gcc.sh || \
		die "gcc build failed"

	./build-gdb.sh || \
		die "gdb build failed"

	./build-avrlibc.sh || \
		die "avrlibc build failed"

	./build-libelf.sh || \
		die "libelf build failed"

	[ `uname` = MINGW32_NT-6.1 ] && {
			./build-glut.sh  || \
					die "glut build failed"
	}

	./build-simavr.sh || \
		die "simavr build failed"
) &

# Need this sleep here otherwise the configure for gmp fails - unable to rm test executables
sleep 30

(
	./build-make.sh || \
		die "make build failed"
) &

(
	./build-libusb.sh || \
		die "libusb build failed"

	./build-avrdude.sh || \
		die "AVRDUDE build failed"
) &

(
	./build-sqlite.sh || \
		die "sqlite build failed"

	./build-smatch.sh || \
		die "smatch build failed"
) &

wait

test -f $FAIL_SENTRY && \
	rm $FAIL_SENTRY && \
	exit 1

./strip.sh

cp LICENSE.txt $PREFIX
cp README.txt $PREFIX

case `uname` in
	Darwin)
		;;
	Linux)
		;;
	*)
		cp avrvars.bat $PREFIX
		;;
esac


