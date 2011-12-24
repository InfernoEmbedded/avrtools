#!/bin/sh

. ./config.sh

echod "Building smatch"

cd build/smatch || \
	die "Could not CD to build/smatch"

$MAKE >$LOGS/smatch-make.log 2>&1

$MAKE install >$LOGS/smatch-install.log 2>&1

cp LICENSE $PREFIX/licenses/LICENSE.smatch

echod "Done building smatch"
