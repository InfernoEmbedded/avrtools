#!/bin/sh

. ./config.sh

test -d download || \
	mkdir download

cd download
#$FETCH http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-core-${GCC_VERSION}.tar.bz2 &
#$FETCH http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-g++-${GCC_VERSION}.tar.bz2 &
# Use for GCC snapshot
$FETCH http://gcc.petsads.us/snapshots/${GCC_VERSION}/gcc-${GCC_VERSION}.tar.bz2 &
$FETCH http://ftp.gnu.org/gnu/make/make-${MAKE_VERSION}.tar.bz2 &
$FETCH http://ftp.gnu.org/gnu/gmp/gmp-${GMP_VERSION}.tar.bz2 &
$FETCH http://ftp.gnu.org/gnu/mpfr/mpfr-${MPFR_VERSION}.tar.bz2 &
$FETCH http://www.multiprecision.org/mpc/download/mpc-${MPC_VERSION}.tar.gz &
# $FETCH http://www.cs.unipr.it/ppl/Download/ftp/releases/${PPL_VERSION}/ppl-${PPL_VERSION}.tar.bz2 &
# $FETCH ftp://gcc.gnu.org/pub/gcc/infrastructure/cloog-ppl-${CLOOG_PPL_VERSION}.tar.gz &
$FETCH http://download-mirror.savannah.gnu.org/releases/avrdude/avrdude-${AVRDUDE_VERSION}.tar.gz &
$FETCH http://download-mirror.savannah.gnu.org/releases/avrdude/avrdude-doc-${AVRDUDE_VERSION}.tar.gz &
#$FETCH http://ftp.gnu.org/gnu/autoconf/autoconf-${AUTOCONF_VERSION}.tar.gz &
$FETCH http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.bz2 &
$FETCH http://ftp.gnu.org/gnu/libtool/libtool-${LIBTOOL_VERSION}.tar.gz &
$FETCH http://download-mirror.savannah.gnu.org/releases/avr-libc/avr-libc-${AVRLIBC_VERSION}.tar.bz2 &
#$FETCH http://downloads.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz &
$FETCH http://www.sqlite.org/sqlite-autoconf-${SQLITE_VERSION}.tar.gz &
$FETCH http://www.splint.org/downloads/splint-${SPLINT_VERSION}.src.tgz &
$FETCH http://coccinelle.lip6.fr/distrib/coccinelle-${COCCINELLE_VERSION}.tgz &

#$FETCH http://mirrors-us.seosue.com/gcc/snapshots/4.6-20110930/gcc-4.6-20110930.tar.bz2 &

case `uname` in
	Darwin)
		$FETCH http://sourceforge.net/projects/libusb/files/libusb-1.0/libusb-${LIBUSB_VERSION}/libusb-${LIBUSB_VERSION}.tar.bz2/download
		mv download libusb-${LIBUSB_VERSION}.tar.bz2&
		;;
	Linux)
		$FETCH http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-${LIBUSB_VERSION}/libusb-${LIBUSB_VERSION}.tar.bz2
		;;
	*)
		$FETCH http://downloads.sourceforge.net/project/libusb-win32/libusb-win32-releases/${LIBUSB_WIN32_VERSION}/libusb-win32-device-bin-${LIBUSB_WIN32_VERSION}.tar.gz &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/coreutils/coreutils-5.97-3/coreutils-${COREUTILS_VERSION}-msys-1.0.13-bin.tar.lzma &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/coreutils/coreutils-5.97-3/coreutils-${COREUTILS_VERSION}-msys-1.0.13-lang.tar.lzma &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/coreutils/coreutils-5.97-3/coreutils-${COREUTILS_VERSION}-msys-1.0.13-ext.tar.lzma &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/coreutils/coreutils-5.97-3/coreutils-${COREUTILS_VERSION}-msys-1.0.13-doc.tar.lzma &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/coreutils/coreutils-5.97-3/coreutils-${COREUTILS_VERSION}-msys-1.0.13-lic.tar.lzma &
		;;
esac

wait

GIT="`which git`"
test -z "$GIT" && \
	GIT="/c/Program Files (x86)/git/bin/git.exe"
test ! -f "$GIT" && \
	GIT="/c/Program Files/git/bin/git.exe"
test ! -f "$GIT" && \
	die "git not found"

#test -d ppl || \
#	"$GIT" clone git://git.cs.unipr.it/ppl/ppl.git &

#test -d simulavr || \
#	"$GIT" clone git://git.sv.gnu.org/simulavr.git &

test -d mhvlib || \
	"$GIT" clone http://git.makehackvoid.com/mhvlib.git &

test -d smatch || \
	"$GIT" clone git://repo.or.cz/smatch.git &


wait

