#!/bin/sh

. config.sh

echod "Building libusb ${LIBUSB_VERSION}"

cd build/libusb-win32-bin-${LIBUSB_VERSION} || \
	die "Could not CD to build/libusb-win32-bin-${LIBUSB_VERSION}"

cp bin/x86/* $PREFIX/bin

for file in COPYING*; do
	cp $file $PREFIX/licenses/$file.libusb
done

echod "Done building libusb ${LIBUSB_VERSION}"