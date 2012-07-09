#!/bin/sh

. ./config.sh

bootstrap libusb

case `uname` in
	Darwin)
		echod "Building libusb ${LIBUSB_VERSION}"

		cd build/libusb-${LIBUSB_VERSION} || \
			die "Could not CD to build/libusb-$LIBUS_VERSION"

		test -f config.log || {
			./configure --prefix=$PREFIX >$LOGS/libusb-config.log 2>&1 || \
				die "Could not configure libusb $LIBUSB_VERSION"
		}

		$MAKE $MAKEFLAGS >$LOGS/libusb-make.log 2>&1 || \
        		die "Could not build libusb ${LIBUSB_VERSION}"

		$MAKE install >$LOGS/libusb-install.log 2>&1 || \
        		die "Could not install libusb ${LIBUSB_VERSION}"
		;;
	Linux)
		echod "Building libusb ${LIBUSB_VERSION}"

		cd build/libusb-${LIBUSB_VERSION} || \
			die "Could not CD to build/libusb-$LIBUS_VERSION"

		test -f config.log || {
			./configure --prefix=$PREFIX >$LOGS/libusb-config.log 2>&1 || \
				die "Could not configure libusb $LIBUSB_VERSION"
		}

		$MAKE $MAKEFLAGS >$LOGS/libusb-make.log 2>&1 || \
        		die "Could not build libusb ${LIBUSB_VERSION}"

		$MAKE install >$LOGS/libusb-install.log 2>&1 || \
        		die "Could not install libusb ${LIBUSB_VERSION}"
		;;
	*)
		echod "Building libusb ${LIBUSB_WIN32_VERSION}"
		cd build/libusb-win32-device-bin-${LIBUSB_WIN32_VERSION} || \
			die "Could not CD to build/libusb-win32-device-bin-${LIBUSB_WIN32_VERSION}"

		cp bin/* $PREFIX/bin
		;;
esac

for file in COPYING*; do
	cp $file $PREFIX/licenses/$file.libusb
done

echod "Done building libusb ${LIBUSB_VERSION}"
