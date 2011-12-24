#!/bin/sh

. ./config.sh

echod "Building sqlite ${SQLITE_VERSION}"

cd build/sqlite-autoconf-${SQLITE_VERSION} || \
	die "Could not CD to build/sqlite-${SQLITE_VERSION}"


test -f config.status || {
	./configure --prefix=$PREFIX >$LOGS/sqlite-config.log 2>&1 || \
		die "Could not configure sqlite ${SQLITE_VERSION}"
}

$MAKE >$LOGS/sqlite-make.log 2>&1 || \
	die "Could not build sqlite ${SQLITE_VERSION}"

$MAKE install >$LOGS/sqlite-install.log 2>&1 || \
	die "Could not install ${SQLITE_VERSION}"

cd ..

echod "Done building sqlite ${SQLITE_VERSION}"
