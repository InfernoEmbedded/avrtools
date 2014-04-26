#!/bin/sh

. ./config.sh

bootstrap freeglut

echod "Building freeglut ${FREEGLUT_VERSION}"

export PATH="$PATH:$PREFIX/bin"

cd build/freeglut-${FREEGLUT_VERSION} || \
	die "Could not CD to build/freeglut-${FREEGLUT_VERSION}"

test -f config.status || {
	./configure --prefix=$LIBPREFIX  >$LOGS/freeglut-${FREEGLUT_VERSION}-config.log 2>&1 || \
		die "Could not configure GETTEXT ${GETTEXT_VERSION}"
}

$MAKE >$LOGS/freeglut-${FREEGLUT_VERSION}-make.log 2>&1 || \
	die "Could not build GETTEXT ${GETTEXT_VERSION}"

$MAKE install >$LOGS/freeglut-${FREEGLUT_VERSION}-install.log 2>&1 || \
	die "Could not install ${GETTEXT_VERSION}"

for file in COPYING*; do
	cp $file $PREFIX/licenses/$file.freeglut
done

echod "Done building freeglut ${FREEGLUT_VERSION}"

