#!/bin/sh

. ./config.sh

mkdir logs
mkdir build
cd build
mkdir bin

echod Extracting native toolchain
mkdir native
cd native
tar jxf ../../download/binutils*.bz2
tar jxf ../../download/gmp*.bz2
tar jxf ../../download/mpfr*.bz2
tar zxf ../../download/mpc*.tar.gz
cd ..

for file in ../download/*.bz2; do
	test -e $file || \
		continue
	echod "Extracting $file"
	tar jxf $file
done

for file in ../download/*.gz ../download/*.tgz; do
	test -e $file || \
		continue
	echod "Extracting $file"
	tar zxf $file
done

for file in ../download/*.zip; do
	test -e $file || \
		continue
	echod "Extracting $file"
	unzip $file
done

for file in ../download/*.xz; do
	test -e $file || \
		continue
	echod "Extracting $file"
	xz -d -c $file | tar xf -
done

cp -R ../download/smatch smatch
cp -R ../download/mhvlib mhvlib
cp -R ../download/simavr simavr

cd binutils-${BINUTILS_VERSION}
for file in ../../patches/binutils-*.patch; do
	echod Patching with $file
	patch -p0 < $file || \
		die "Patch failed"
done
cd ..

#cd avr-libc-${AVRLIBC_VERSION}
#for file in ../../patches/avr-libc-*.patch; do
#	echod Patching with $file
#	patch -p0 < $file || \
#		die "Patch failed"
#done
#cd ..

#cd gcc-${GCC_VERSION}
#for file in ../../patches/gcc-*.patch; do
#	echod Patching with $file
#	patch -p0 < $file || \
#		die "Patch failed"
#done
#cd ..

cd gmp-${GMP_VERSION}
for file in ../../patches/gmp-*.patch; do
	echod Patching with $file
	patch -p0 < $file || \
		die "Patch failed"
done
cd ..

cd make-${MAKE_VERSION}
for file in ../../patches/make-*.patch; do
	echod Patching with $file
	patch -p1 < $file || \
		die "Patch failed"
done
cd ..

cd smatch
for file in ../../patches/smatch-*.patch; do
	echod Patching with $file
	patch -p1 < $file || \
		die "Patch failed"
done
cd ..

cd simavr
for file in ../../patches/simavr-*.patch; do
	echod Patching with $file
	patch -p1 < $file || \
		die "Patch failed"
done
cd ..


#cd coccinelle-${COCCINELLE_VERSION}
#for file in ../../patches/coccinelle-*.patch; do
#	echod Patching with $file
#	patch -p1 < $file || \
#		die "Patch failed"
#done
#cd ..

