#AUTOCONF_VERSION=2.67
#AUTOCONF_VERSION=2.61
BINUTILS_VERSION=2.22
LIBTOOL_VERSION=2.4
GCC_VERSION=4.6-20120106
MAKE_VERSION=3.82
GMP_VERSION=5.0.2
MPFR_VERSION=3.1.0
MPC_VERSION=0.8.2
# MPC 0.9 does not build on win32
#MPC_VERSION=0.9
SWIG_VERSION=2.0.4
# Currently using the GIT version until the release supports GMP 5
#PPL_VERSION=0.10.2
#CLOOG_PPL_VERSION=0.15.9
AVRLIBC_VERSION=1.8.0
AVRDUDE_VERSION=5.11.1
LIBUSB_VERSION=1.0.8
LIBUSB_WIN32_VERSION=0.1.12.2
#SQLITE_VERSION=3.7.5
SQLITE_VERSION=3070800
SPLINT_VERSION=3.1.2
GNU_COREUTILS_VERSION=5.3.0
COCCINELLE_VERSION=1.0.0-rc7

export TOP=`pwd`
export BUILD="$TOP/build"
export PREFIX="$TOP/mhvavrtools"

case `uname` in
	Darwin)
		export ABI=64
		export CC=/usr/bin/gcc-4.2
		;;
	Linux)
		case `uname -m` in
			i686)
				export ABI=32
				;;
		esac
		;;

	*)
		export ABI=32

		export PATH="/mingw/bin:/bin:/usr/local/bin:/bin:/c/Python2.7:/c/Windows/system32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/system32/wbem:/c/Program Files (x86)/Objective Caml/bin:/c/Program Files/Objective Caml/bin:/c/Program Files (x86)/flexdll:/c/Program Files/flexdll"
		;;
esac

export LIBPREFIX="$TOP/build/bin"
LOGS="$TOP/logs"
FAIL_SENTRY="$TOP/.failed"


#M4=m4
#export M4

#CFLAGS="-mtune=corei7"
#export CFLAGS

CPPFLAGS="-I$PREFIX/include -I$LIBPREFIX/include"
export CPPFLAGS

LDFLAGS="-L$PREFIX/lib -L$LIBPREFIX/lib"
export LDFLAGS

MAKEFLAGS=""





MAKE="make"
export MAKE

FETCH="`which wget`"
if test -x "$FETCH"; then
	FETCH="$FETCH -c"
else
	FETCH="curl -O -C - -L"
fi
export FETCH


echod() {
	echo `date`: $*
}

die() {
	echod $*
	touch "$FAIL_SENTRY"
	exit 1
}

