#!/bin/sh
. ./config.sh

GIT="`which git`"
test -z "$GIT" && \
	GIT="/c/Program Files (x86)/git/bin/git.exe"
test ! -f "$GIT" && \
	GIT="/c/Program Files/git/bin/git.exe"
test ! -f "$GIT" && \
	die "git not found"

test -d download || \
	mkdir download

cd download
$FETCH http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.bz2 &
# Use for GCC snapshot
#$FETCH http://gcc.parentingamerica.com/snapshots/${GCC_VERSION}/gcc-${GCC_VERSION}.tar.bz2 &
$FETCH http://ftp.gnu.org/gnu/make/make-${MAKE_VERSION}.tar.bz2 &
$FETCH http://ftp.gnu.org/gnu/gmp/gmp-${GMP_VERSION}.tar.bz2 &
$FETCH http://ftp.gnu.org/gnu/mpfr/mpfr-${MPFR_VERSION}.tar.bz2 &
$FETCH http://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.bz2 &
$FETCH http://ftp.gnu.org/gnu/gawk/gawk-${GAWK_VERSION}.tar.gz &
$FETCH http://www.multiprecision.org/mpc/download/mpc-${MPC_VERSION}.tar.gz &
$FETCH ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-${ISL_VERSION}.tar.bz2 &
$FETCH ftp://gcc.gnu.org/pub/gcc/infrastructure/cloog-${CLOOG_VERSION}.tar.gz &
$FETCH http://download-mirror.savannah.gnu.org/releases/avrdude/avrdude-${AVRDUDE_VERSION}.tar.gz &
$FETCH http://download-mirror.savannah.gnu.org/releases/avrdude/avrdude-doc-${AVRDUDE_VERSION}.tar.gz &
#$FETCH http://ftp.gnu.org/gnu/autoconf/autoconf-${AUTOCONF_VERSION}.tar.gz &
#$FETCH http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.bz2 &
# Used for binutils snapshots
$FETCH ftp://sourceware.org/pub/binutils/snapshots/binutils-${BINUTILS_VERSION}.tar.bz2 &
$FETCH http://ftp.gnu.org/gnu/libtool/libtool-${LIBTOOL_VERSION}.tar.gz &
#$FETCH http://download-mirror.savannah.gnu.org/releases/avr-libc/avr-libc-${AVRLIBC_VERSION}.tar.bz2 &
#$FETCH http://downloads.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz &
$FETCH http://www.sqlite.org/2013/sqlite-autoconf-${SQLITE_VERSION}.tar.gz &
$FETCH http://www.splint.org/downloads/splint-${SPLINT_VERSION}.src.tgz &
$FETCH http://coccinelle.lip6.fr/distrib/coccinelle-${COCCINELLE_VERSION}.tgz &
$FETCH http://www.mr511.de/software/libelf-${LIBELF_VERSION}.tar.gz &

case `uname` in
	Darwin)
		$FETCH http://downloads.sourceforge.net/project/libusbx/releases/${LIBUSB_VERSION}/source/libusbx-${LIBUSB_VERSION}.tar.bz2 
		mv download libusb-${LIBUSB_VERSION}.tar.bz2&

		test -d gcc-4.7-binary && ( \
				cd gcc-4.7-binary
				"$GIT" pull
				cd ..
			) || \
			"$GIT" clone git://github.com/sol-prog/gcc-4.7-binary.git &
		;;

	Linux)
		$FETCH http://downloads.sourceforge.net/project/libusbx/releases/${LIBUSB_VERSION}/source/libusbx-${LIBUSB_VERSION}.tar.bz2 
		;;
	*)
		$FETCH http://downloads.sourceforge.net/project/libusb-win32/libusb-win32-releases/${LIBUSB_WIN32_VERSION}/libusb-win32-device-bin-${LIBUSB_WIN32_VERSION}.tar.gz &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/coreutils/coreutils-5.97-3/coreutils-${COREUTILS_VERSION}-msys-1.0.13-bin.tar.lzma &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/coreutils/coreutils-5.97-3/coreutils-${COREUTILS_VERSION}-msys-1.0.13-lang.tar.lzma &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/coreutils/coreutils-5.97-3/coreutils-${COREUTILS_VERSION}-msys-1.0.13-ext.tar.lzma &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/coreutils/coreutils-5.97-3/coreutils-${COREUTILS_VERSION}-msys-1.0.13-doc.tar.lzma &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/coreutils/coreutils-5.97-3/coreutils-${COREUTILS_VERSION}-msys-1.0.13-lic.tar.lzma &
		$FETCH http://downloads.sourceforge.net/project/mingw/MSYS/Base/msys-core/msys-${MSYS_CORE_VERSION}-1/msysCORE-${MSYS_CORE_VERSION}-1-msys-${MSYS_CORE_VERSION}-bin.tar.lzma &
		$FETCH http://downloads.sourceforge.net/project/freeglut/freeglut/${FREEGLUT_VERSION}/freeglut-${FREEGLUT_VERSION}.tar.gz &
		$FETCH http://ftp.gnu.org/pub/gnu/libiconv/libiconv-${LIBICONV_VERSION}.tar.gz &
		$FETCH http://ftp.gnu.org/pub/gnu/gettext/gettext-${GETTEXT_VERSION}.tar.gz &
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

SVN="`which svn`"

#test -d ppl || \
#	"$GIT" clone git://git.cs.unipr.it/ppl/ppl.git &

#test -d simulavr || \
#	"$GIT" clone git://git.sv.gnu.org/simulavr.git &


test -d simavr && ( \
		cd simavr
		"$GIT" pull
		cd ..
	) || \
	"$GIT" clone git://gitorious.org/simavr/simavr.git &

test -d flame && ( \
		cd flame
		"$GIT" pull
		cd ..
	) || \
	"$GIT" clone http://git.infernoembedded.com/flame.git &

test -d smatch && ( \
		cd smatch
		"$GIT" pull
	) || \
	"$GIT" clone git://repo.or.cz/smatch.git &

test -d avr-libc && ( \
		cd avr-libc
		"$SVN" update
	) || \
	"$SVN" co svn://svn.sv.gnu.org/avr-libc/trunk/avr-libc  &

test -d binutils-gdb && ( \
		cd binutils-gdb
		"$GIT" pull
	) || \
	"$GIT" clone git://sourceware.org/git/binutils-gdb.git &

wait

