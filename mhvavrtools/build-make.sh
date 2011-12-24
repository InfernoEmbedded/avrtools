#!/bin/sh

. ./config.sh

echod "Building make ${MAKE_VERSION}"

cd build/make-${MAKE_VERSION} || \
	die "Could not CD to build/make-${MAKE_VERSION}"

case `uname` in
	Linux)
		./configure --prefix=$PREFIX >$LOGS/make-configure.log 2>&1 || \
			die "Could not configure make ${MAKE_VERSION}"

		$MAKE $MAKEFLAGS >$LOGS/make-make.log 2>&1 || \
			die "Could not make make ${MAKE_VERSION}"

		$MAKE install >$LOGS/make-install.log 2>&1 || \
			die "Could not install make ${MAKE_VERSION}"
		;;
	*)
		$TOP/patches/make-build-msys.sh >$LOGS/make.log 2>&1
		;;
esac

cp COPYING $PREFIX/licenses/COPYING.make

echod "Done building make ${MAKE_VERSION}"
