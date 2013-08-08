#!/bin/sh

. ./config.sh

bootstrap iconv

echod "Building iconv ${LIBICONV_VERSION}"

cd build/libiconv-${LIBICONV_VERSION} || \
	die "Could not CD to build/iconv-${LIBICONV_VERSION}"

test -f config.status || {
	./configure --prefix=$LIBPREFIX --enable-static --disable-shared >$LOGS/iconv-config.log 2>&1 || \
		die "Could not configure ICONV ${LIBICONV_VERSION}"
}

$MAKE >$LOGS/iconv-make.log 2>&1 || \
	die "Could not build ICONV ${ICONV_VERSION}"

#$MAKE  check || \
#	die "ICONV ${ICONV_VERSION} tests failed"

$MAKE install >$LOGS/iconv-install.log 2>&1 || \
	die "Could not install ${ICONV_VERSION}"

for file in COPYING*; do
	cp $file $PREFIX/licenses/$file.iconv
done

echod "Done building iconv ${LIBICONV_VERSION}"
