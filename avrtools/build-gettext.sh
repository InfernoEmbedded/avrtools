#!/bin/sh

. ./config.sh

bootstrap gettext

echod "Building gettext ${GETTEXT_VERSION}"

cd build/gettext-${GETTEXT_VERSION} || \
	die "Could not CD to build/gettext-${GETTEXT_VERSION}"

test -f config.status || {
	./configure --prefix=$LIBPREFIX --enable-static --disable-shared --with-libiconv-prefix=$PREFIX --enable-threads=win32 >$LOGS/gettext-config.log 2>&1 || \
		die "Could not configure GETTEXT ${GETTEXT_VERSION}"
}

cd gettext-runtime
$MAKE >$LOGS/gettext-make.log 2>&1 || \
	die "Could not build GETTEXT ${GETTEXT_VERSION}"

#$MAKE  check || \
#	die "GETTEXT ${GETTEXT_VERSION} tests failed"

$MAKE install >$LOGS/gettext-install.log 2>&1 || \
	die "Could not install ${GETTEXT_VERSION}"

for file in COPYING*; do
	cp $file $PREFIX/licenses/$file.gettext
done

echod "Done building gettext ${GETTEXT_VERSION}"
