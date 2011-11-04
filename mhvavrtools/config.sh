#AUTOCONF_VERSION=2.67
#AUTOCONF_VERSION=2.61
BINUTILS_VERSION=2.21.1
LIBTOOL_VERSION=2.4
GCC_VERSION=4.6.2
MAKE_VERSION=3.82
GMP_VERSION=5.0.2
MPFR_VERSION=3.0.1
MPC_VERSION=0.8.2
SWIG_VERSION=2.0.4
# Currently using the GIT version until the release supports GMP 5
#PPL_VERSION=0.10.2
#CLOOG_PPL_VERSION=0.15.9
AVRLIBC_VERSION=1.7.2rc2252
AVRDUDE_VERSION=5.11.1
LIBUSB_VERSION=1.2.5.0
#SQLITE_VERSION=3.7.5
SQLITE_VERSION=3070800
SPLINT_VERSION=3.1.2
GNU_COREUTILS_VERSION=5.3.0
COCCINELLE_VERSION=1.0.0-rc7

TOP=`pwd`
#PREFIX="$TOP/root"
PREFIX="c:/mhvavrtools"
export PREFIX
LOGS="$TOP/logs"
FAIL_SENTRY="$TOP/.failed"

#ABI=32
#export ABI

#M4=m4
#export M4

CPPFLAGS="-I$PREFIX/include"
export CPPFLAGS

LDFLAGS="-L$PREFIX/lib"
export LDFLAGS

MAKEFLAGS=""


PATH="/mingw/bin:/bin:/c/mhvavrtools/bin:/usr/local/bin:/mingw/bin:/bin:/c/Python2.7:/c/Windows/system32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/system32/wbem:/c/Program Files (x86)/Objective Caml/bin:/c/Program Files/Objective Caml/bin:/c/Program Files (x86)/flexdll:/c/Program Files/flexdll"
export PATH



MAKE="/bin/make"
export MAKE

echod() {
	echo `date`: $*
}

die() {
	echod $*
	touch "$FAIL_SENTRY"
	exit 1
}

