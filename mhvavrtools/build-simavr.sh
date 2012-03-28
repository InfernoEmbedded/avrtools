#!/bin/sh

. ./config.sh

echod "Building simavr"

export PATH="$PATH:$PREFIX/bin"

cd build/simavr || \
	die "Could not CD to build/simavr"

$MAKE V=1 AVR_ROOT=$PREFIX AVR_INC=$PREFIX/avr \
	IPATH+=.:`pwd`/include:`pwd`/simavr/sim:`pwd`/examples/parts:$PREFIX/include \
	AVR=$PREFIX/bin/avr- \
		>$LOGS/simavr-make.log 2>&1 || \
			die "Could not make simavr"

cp simavr/obj-*/run_avr.elf $PREFIX/bin/run_avr${EXE}
mkdir -p $PREFIX/simavr/examples
for file in `find examples -name '*.elf'`; do
	newname="`basename $file .elf`"
	cp $file $PREFIX/simavr/examples/${newname}${EXE}
done
cp COPYING $PREFIX/licenses/COPYING.simavr

echod "Done building simavr"
