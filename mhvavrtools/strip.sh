#!/bin/sh

. ./config.sh

case `uname` in
	Linux)
		for file in $PREFIX/bin/*; do
			[ -x $file ] && \
				strip $file
		done
		;;
	*)
		for file in $PREFIX/bin/*.exe $PREFIX/bin/*.dll; do
			strip $file
		done
		;;
esac

for file in `find $PREFIX -name '*.[ao]' | grep /avr`; do
	$PREFIX/bin/avr-strip -g $file
done
