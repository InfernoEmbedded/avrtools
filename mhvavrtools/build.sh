#!/bin/sh

. config.sh

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

(
	./build-coreutils.sh || \
		die "coreutils build failed"

	./build-gmp.sh || \
		die "gmp build failed"

 	./build-mpfr.sh || \
		die "mpfr build failed"

	./build-mpc.sh || \
		die "mpc build failed"
	
	./build-binutils.sh || \
		die "binutils build failed"

	./build-gcc.sh || \
		die "gcc build failed"

	./build-avrlibc.sh || \
		die "avrlibc build failed"
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

test -f $FAIL_SENTRY && (
	rm $FAIL_SENTRY
	exit 1
)

./strip.sh 

cp LICENSE.txt $PREFIX
cp README.txt $PREFIX
cp avrvars.bat $PREFIX
cp install.bat $PREFIX


