#!/bin/sh

. config.sh

for file in $PREFIX/bin/*.exe $PREFIX/bin/*.dll; do
	strip $file
done

for file in `find $PREFIX -name '*.[ao]' | grep /avr`; do
	$PREFIX/bin/avr-strip -g $file
done
