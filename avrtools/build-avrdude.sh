#!/bin/sh

. ./config.sh

bootstrap avrdude

echod "Building AVRDUDE ${AVRDUDE_VERSION}"

cd build/avrdude-${AVRDUDE_VERSION} || \
	die "Could not CD to build/avrdude-${AVRDUDE_VERSION}"

case `uname` in
	Darwin)
		export CFLAGS="$CFLAGS -I$PREFIX/include"
		export LDFLAGS="$LDFLAGS -L$PREFIX/lib -lusb-1.0"

		test -f config.log ||  {
			./configure --prefix=$PREFIX --sysconfdir="$PREFIX/bin" >$LOGS/avrdude-config.log 2>&1 || \
				die "Could not configure AVRDUDE ${AVRDUDE_VERSION}"
		}
		;;
	Linux)
		export CFLAGS="$CFLAGS -I$PREFIX/include"
		export LDFLAGS="$LDFLAGS -L$PREFIX/lib -lusb-1.0"

		test -f config.log ||  {
			./configure --prefix=$PREFIX --sysconfdir="$PREFIX/bin" >$LOGS/avrdude-config.log 2>&1 || \
				die "Could not configure AVRDUDE ${AVRDUDE_VERSION}"
		}
		;;
	*)
		export CFLAGS="$CFLAGS -I$TOP/build/libusb-win32-device-bin-${LIBUSB_WIN32_VERSION}/include"
		export LDFLAGS="$LDFLAGS -L$TOP/build/libusb-win32-device-bin-${LIBUSB_WIN32_VERSION}/lib/gcc -lusb"

		test -f config.log ||  {
			./configure --build=mingw32 --prefix=$PREFIX --sysconfdir="$PREFIX\\bin" >$LOGS/avrdude-config.log 2>&1 || \
				die "Could not configure AVRDUDE ${AVRDUDE_VERSION}"
		}
		;;
esac

$MAKE >$LOGS/avrdude-make.log 2>&1 || \
	die "Could not build AVRDUDE ${AVRDUDE_VERSION}"

$MAKE install >$LOGS/avrdude-install.log 2>&1 || \
	die "Could not install ${AVRDUDE_VERSION}"

cp COPYING $PREFIX/licenses/COPYING.avrdude

echod "Done building AVRDUDE ${AVRDUDE_VERSION}"
