#AUTOCONF_VERSION=2.67
#AUTOCONF_VERSION=2.61
BINUTILS_VERSION=2.22.90
LIBTOOL_VERSION=2.4
GCC_VERSION=4.7.2
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
COREUTILS_VERSION=5.97-3
MSYS_CORE_VERSION=1.0.17
GETTEXT_VERSION=0.18.1.1-1
LIBICONV_VERSION=1.14
COCCINELLE_VERSION=1.0.0-rc7
GLUT_VERSION=3.7.6
GDB_VERSION=7.5

# SimAVR dependancies
LIBELF_VERSION=0.8.9

export TOP=`pwd`
export BUILD="$TOP/build"
export PREFIX="$TOP/mhvavrtools"

case `uname` in
	Darwin)
#		export ABI=32
#		export NATIVECFLAGS="-O3 -m32 -v --save-temps"
		export NATIVECFLAGS="-O3"
		export NATIVECXXFLAGS="-O3"
		export CFLAGS="-O3"
		export CXXFLAGS="-O3"
		export LDFLAGS=""
		export LOCALCC="/usr/gcc-4.7/bin/gcc-4.7"
		export EXE=
		;;
	Linux)
		case `uname -m` in
			i686)
				export ABI=32
				export CFLAGS="-march=atom -flto -O3"
				export CXXFLAGS="-march=atom -flto -O3"
				;;
			*)
				export CFLAGS="-march=corei7 -flto -O3"
				export CXXFLAGS="-march=corei7 -flto -O3"
				;;
			esac
		export EXE=
		export NATIVECFLAGS="-O2"
		export NATIVECXXFLAGS="-O2"
		export LDFLAGS="-flto"
		export LOCALCC="gcc"
		;;
	*)
#		export ABI=32
		export LOCALCC="gcc"
		export PATH="/mingw/bin:/bin:/usr/local/bin:/c/Python2.7:/c/Windows/system32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/system32/wbem:/c/Program Files (x86)/Objective Caml/bin:/c/Program Files/Objective Caml/bin:/c/Program Files (x86)/flexdll:/c/Program Files/flexdll"
		export EXE=".exe"
		export NATIVECFLAGS="-O2"
		export NATIVECXXFLAGS="-O2"
		export CFLAGS="-march=atom -flto -O3"
		export CXXFLAGS="-march=atom -flto -O3"
		export LDFLAGS="-flto"
		;;
esac

export LIBPREFIX="$TOP/build/bin"
export NATIVEPREFIX="$TOP/build/native"
LOGS="$TOP/logs"
FAIL_SENTRY="$TOP/.failed"


MAKEFLAGS="-j 8"

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

native() {
	product="$1"

	case $product in
	*)
		CFLAGS="$NATIVECFLAGS -I$NATIVEPREFIX/include"
		export CFLAGS

		CXXFLAGS="$NATIVECXXFLAGS -I$NATIVEPREFIX/include"
		export CPPFLAGS

		LDFLAGS="-L$NATIVEPREFIX/lib"
		export LDFLAGS

		case `uname` in
			Darwin)
				export CC="$TOP/patches/gcc-wrapper.sh"
				export PATH="/usr/gcc-4.7/bin/:/usr/bin:$PATH"
				;;
			*)
				export CC="$LOCALCC"
				;;
		esac

		export LD="ld"
		;;
	esac
}

avr() {
	product="$1"

	case $product in
	*)
		export CFLAGS="-flto -Os"
		export CXXFLAGS="-flto -Os"
		export PATH="$PATH:$PREFIX/bin"
		export CC="$PREFIX/bin/avr-gcc"
		export LD="$PREFIX/bin/avr-ld"
		;;
	esac
}

bootstrap() {
	product="$1"

	export CFLAGS="$CFLAGS -I$PREFIX/include -I$LIBPREFIX/include"
	export CXXFLAGS="$CXXFLAGS -I$PREFIX/include -I$LIBPREFIX/include"
	export LDFLAGS="-flto -L$PREFIX/lib -L$LIBPREFIX/lib"
	export CC="$NATIVEPREFIX/bin/gcc"
	export LD="$NATIVEPREFIX/bin/ld"
	export PATH="$NATIVEPREFIX/bin:$PATH"

	case $product in
	binutils|gcc)
		case `uname` in
			MINGW32_NT-6.1)
				native $product
			;;
		esac
		;;
	esac
}
