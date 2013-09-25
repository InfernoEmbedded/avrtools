#AUTOCONF_VERSION=2.67
#AUTOCONF_VERSION=2.61
BINUTILS_VERSION=2.23.52
LIBTOOL_VERSION=2.4.2
GCC_VERSION=4.8-20130808
MAKE_VERSION=3.82
GMP_VERSION=5.1.2
MPFR_VERSION=3.1.2
MPC_VERSION=1.0.1
# MPC 0.9 does not build on win32
#MPC_VERSION=0.9
SWIG_VERSION=2.0.10
ISL_VERSION=0.11.1
CLOOG_VERSION=0.18.0
AVRLIBC_VERSION=1.8.0
AVRDUDE_VERSION=6.0rc1
LIBUSB_VERSION=1.0.9
LIBUSB_WIN32_VERSION=0.1.12.2
#SQLITE_VERSION=3.7.5
SQLITE_VERSION=3070800
SPLINT_VERSION=3.1.2
COREUTILS_VERSION=5.97-3
COCCINELLE_VERSION=1.0.0-rc17
GLUT_VERSION=3.7.6
GDB_VERSION=7.6

# SimAVR dependancies
LIBELF_VERSION=0.8.9

# Windows Only
MSYS_CORE_VERSION=1.0.17
GETTEXT_VERSION=0.18.1.1
LIBICONV_VERSION=1.14

export TOP=`pwd`
export BUILD="$TOP/build"
export PREFIX="$TOP/mhvavrtools"

case `uname` in
	Darwin)
		export ABI=64
		export NATIVECFLAGS="-O2"
		export NATIVECXXFLAGS="-O2"
		export CFLAGS="-march=corei7 -O2"
		export CXXFLAGS="-march=corei7 -O2"
		export LDFLAGS=""
		export LOCALCC="$BUILD/gcc-4.7.1/bin/gcc-4.7"
		export LOCALCXX="$BUILD/gcc-4.7.1/bin/g++-4.7"
		export DYLD_LIBRARY_PATH="$BUILD/gcc-4.7.1/lib"
		export EXE=
		export PATH="`dirname $LOCALCC`:$PATH"
		;;
	Linux)
		case `uname -m` in
			i686)
				export ABI=32
				export CFLAGS="-march=atom -flto -O2"
				export CXXFLAGS="-march=atom -flto -O2"
				;;
			*)
				export CFLAGS="-march=corei7 -flto -O2"
				export CXXFLAGS="-march=corei7 -flto -O2"
				;;
			esac
		export EXE=
		export NATIVECFLAGS="-O2"
		export NATIVECXXFLAGS="-O2"
		export LDFLAGS="-flto"
		export LOCALCC="gcc"
		export LOCALCXX="g++"
		;;
	*)
		export ABI=32
		export LOCALCC="gcc"
		export LOCALCXX="g++"
		export PATH="/mingw/bin:/bin:/usr/local/bin:/c/Python2.7:/c/Windows/system32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/system32/wbem:/c/Program Files (x86)/Objective Caml/bin:/c/Program Files/Objective Caml/bin:/c/Program Files (x86)/flexdll:/c/Program Files/flexdll"
		export EXE=".exe"
		export NATIVECFLAGS="-O2"
		export NATIVECXXFLAGS="-O2"
		export CFLAGS="-march=atom -flto -O2"
		export CXXFLAGS="-march=atom -flto -O2"
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

		export CC="$LOCALCC"
		export CXX="$LOCALCXX"

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
		export CXX="$PREFIX/bin/avr-g++"
		export LD="$PREFIX/bin/avr-ld"
		;;
	esac
}

bootstrap() {
	product="$1"

	export CFLAGS="$CFLAGS -I$PREFIX/include -I$LIBPREFIX/include"
	export CXXFLAGS="$CXXFLAGS -I$PREFIX/include -I$LIBPREFIX/include"
	export LDFLAGS="-flto -L$PREFIX/lib -L$LIBPREFIX/lib -static-libgcc -static-libstdc++"
	export CC="$NATIVEPREFIX/bin/gcc"
	export CXX="$NATIVEPREFIX/bin/g++"
	export LD="$NATIVEPREFIX/bin/ld"
	export PATH="$NATIVEPREFIX/bin:$PATH"
	
	case $product in
	libusb)
		case `uname` in
			Darwin)
				CC=/usr/bin/gcc
				CFLAGS="$NATIVECFLAGS"
				;;
		esac
		;;
	gcc)
		AVRCFLAGS="-Os"
		case `uname` in
			Darwin)
				CFLAGS="$NATIVECFLAGS"
				;;
			MINGW32_NT-6.1)
				export LDFLAGS="-L$PREFIX/lib -L$LIBPREFIX/lib -static-libgcc -static-libstdc++"
				for file in `find $LIBPREFIX -name '*.a'`; do
					LDFLAGS="$LDFLAGS $file"
				done
				export GCCCONFIGFLAGS="--disable-shared --enable-static --disable-bootstrap"				
			# Disable LTO
				export CFLAGS="-O2 -I$PREFIX/include -I$LIBPREFIX/include"
				export CXXFLAGS="-O2 -I$PREFIX/include -I$LIBPREFIX/include"			
				;;
		esac
		;;
	gdb)
		case `uname` in
			MINGW32_NT-6.1)
				for file in `find $LIBPREFIX -name '*.a'`; do
					LDFLAGS="$LDFLAGS $file"
				done
				export GDBCONFIGFLAGS="--disable-shared --enable-static"
				;;
		esac
		;;
	gettext)
		case `uname` in
			MINGW32_NT-6.1)			
				native gettext
				;;
		esac
		;;
	esac
}
