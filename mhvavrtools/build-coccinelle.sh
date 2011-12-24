#!/bin/sh

. ./config.sh

echod "Building coccinelle ${COCCINELLE_VERSION}"

cd build/coccinelle-${COCCINELLE_VERSION} || \
	die "Could not CD to build/coccinelle-${COCCINELLE_VERSION}"

./configure --prefix=/c/mhvavrtools-bin >$LOGS/coccinelle-config.log 2>&1 || \
	die "Could not configure coccinelle-${COCCINELLE_VERSION}"

make depend >$LOGS/coccinelle-make-depend.log 2>&1 || \
	die "Could not make depend"

make all >$LOGS/coccinelle-make.log 2>&1 || \
	die "Could not make"

make install >$LOGS/coccinelle-make-install.log 2>&1 || \
	die "Could not make install"

cp copyright.txt $PREFIX/licenses/copyright.coccinelle

echod "Done building coccinelle ${COCCINELLE_VERSION}"
