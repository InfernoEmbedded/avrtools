#!/bin/sh

. config.sh

test -d download || \
	mkdir download

cd download
wget -c http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-core-${GCC_VERSION}.tar.bz2 &
wget -c http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-g++-${GCC_VERSION}.tar.bz2 &
wget -c http://ftp.gnu.org/gnu/make/make-${MAKE_VERSION}.tar.bz2 &
wget -c http://ftp.gnu.org/gnu/gmp/gmp-${GMP_VERSION}.tar.bz2 &
wget -c http://ftp.gnu.org/gnu/mpfr/mpfr-${MPFR_VERSION}.tar.bz2 &
wget -c http://www.multiprecision.org/mpc/download/mpc-${MPC_VERSION}.tar.gz &
#wget -c http://www.cs.unipr.it/ppl/Download/ftp/releases/${PPL_VERSION}/ppl-${PPL_VERSION}.tar.bz2 &
wget -c ftp://gcc.gnu.org/pub/gcc/infrastructure/cloog-ppl-${CLOOG_PPL_VERSION}.tar.gz &
wget -c http://download-mirror.savannah.gnu.org/releases/avrdude/avrdude-${AVRDUDE_VERSION}.tar.gz &
wget -c http://download-mirror.savannah.gnu.org/releases/avrdude/avrdude-doc-${AVRDUDE_VERSION}.tar.gz &
#wget -c http://ftp.gnu.org/gnu/autoconf/autoconf-${AUTOCONF_VERSION}.tar.gz &
wget -c http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.bz2 &
wget -c http://ftp.gnu.org/gnu/libtool/libtool-${LIBTOOL_VERSION}.tar.gz &
wget -c http://download-mirror.savannah.gnu.org/releases/avr-libc/avr-libc-${AVRLIBC_VERSION}.tar.bz2 &
#wget -c http://downloads.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz &
wget -c http://downloads.sourceforge.net/project/libusb-win32/libusb-win32-releases/${LIBUSB_VERSION}/libusb-win32-bin-${LIBUSB_VERSION}.zip &
wget -c http://www.sqlite.org/sqlite-autoconf-${SQLITE_VERSION}.tar.gz &
wget -c http://www.splint.org/downloads/splint-${SPLINT_VERSION}.src.tgz &
wget -c http://sourceforge.net/projects/gnuwin32/files/coreutils/${GNU_COREUTILS_VERSION}/coreutils-${GNU_COREUTILS_VERSION}-bin.zip &
wget -c http://coccinelle.lip6.fr/distrib/coccinelle-${COCCINELLE_VERSION}.tgz &

#wget -c http://mirrors-us.seosue.com/gcc/snapshots/4.6-20110930/gcc-4.6-20110930.tar.bz2 &

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
