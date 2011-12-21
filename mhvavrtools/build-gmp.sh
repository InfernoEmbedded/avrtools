#!/bin/sh

. config.sh

echod "Building GMP ${GMP_VERSION}"

cd build/gmp-${GMP_VERSION} || \
	die "Could not CD to build/gmp-${GMP_VERSION}"

test -f config.log || {
	./configure --prefix=$LIBPREFIX --enable-cxx --enable-static \
	   >$LOGS/gmp-config.log 2>&1 || \
		die "Could not configure GMP ${GMP_VERSION}"
}

find . -name '*.lo' -exec dos2unix {} \;

$MAKE >$LOGS/gmp-make.log 2>&1 || \
	die "Could not build GMP ${GMP_VERSION}"

#$MAKE  -j 4 check || \
#	die "GMP ${GMP_VERSION} tests failed"

$MAKE install >$LOGS/gmp-install.log 2>&1 || \
	die "Could not install ${GMP_VERSION}"

for file in COPYING*; do
	cp $file $PREFIX/licenses/$file.gmp
done

echod "Done building GMP ${GMP_VERSION}"
