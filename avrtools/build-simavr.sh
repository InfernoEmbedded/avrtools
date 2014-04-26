#!/bin/sh

. ./config.sh

bootstrap simavr

echod "Building simavr"

export PATH="$PATH:$PREFIX/bin"

cd build/simavr || \
	die "Could not CD to build/simavr"

if [ `uname` = MINGW32_NT-6.1 ]; then
	WIN=Msys
fi

$MAKE WIN=$WIN V=1 AVR_ROOT=$PREFIX AVR_INC=$PREFIX/avr \
	IPATH+=.:`pwd`/include:`pwd`/simavr/sim:`pwd`/examples/parts:`pwd`/examples/shared:$PREFIX/include \
	AVR=$PREFIX/bin/avr- \
		>$LOGS/simavr-make.log 2>&1 || \
			die "Could not make simavr"

cp simavr/obj-*/run_avr.elf $PREFIX/bin/run_avr${EXE}
mkdir -p $PREFIX/simavr/examples
for file in `find examples -name '*.elf'`; do
	newname="`basename $file .elf`"
	cp $file $PREFIX/simavr/examples/${newname}${EXE}
done

mkdir $PREFIX/avr/include/simavr
cp simavr/sim/avr/avr_mcu_section.h $PREFIX/avr/include/simavr/

cp COPYING $PREFIX/licenses/COPYING.simavr
echod "Done building simavr"

