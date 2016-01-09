#BINUTILS_VERSION=2.25.1
BINUTILS_VERSION=gdb
LIBTOOL_VERSION=2.4.6
GAWK_VERSION=4.1.3
GCC_VERSION=5.3.0
MAKE_VERSION=4.1
GMP_VERSION=6.1.0
MPFR_VERSION=3.1.3
MPC_VERSION=1.0.3
SWIG_VERSION=3.0.7
ISL_VERSION=0.15
AVRLIBC_VERSION=1.8.1
AVRDUDE_VERSION=6.2
LIBUSB_VERSION=1.0.20
LIBUSB_WIN32_VERSION=0.1.12.2
SQLITE_VERSION=3090200
SPLINT_VERSION=3.1.2
COREUTILS_VERSION=5.97-3
COCCINELLE_VERSION=1.0.4
FREEGLUT_VERSION=3.0.0
GDB_VERSION=7.10.1

# SimAVR dependancies
LIBELF_VERSION=0.8.13

# Windows Only
MSYS_CORE_VERSION=1.0.18
GETTEXT_VERSION=0.19.5.1
LIBICONV_VERSION=1.14

export TOP=`pwd`
export BUILD="$TOP/build"
export PREFIX="$TOP/avrtools"

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
				export CFLAGS="-march=atom -O2"
				export CXXFLAGS="-march=atom -O2"
				;;
			*)
				export CFLAGS="-march=corei7 -O2"
				export CXXFLAGS="-march=corei7 -O2"
				;;
			esac
		export EXE=
		export NATIVECFLAGS="-O2"
		export NATIVECXXFLAGS="-O2"
		export LDFLAGS=""
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
		export LDFLAGS=""
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
	export PATH="$NATIVEPREFIX/bin:$PATH"

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
	export LDFLAGS="-L$PREFIX/lib -L$LIBPREFIX/lib -static-libgcc -static-libstdc++"
	export CC="$NATIVEPREFIX/bin/gcc"
	export CXX="$NATIVEPREFIX/bin/g++"
	export LD="$NATIVEPREFIX/bin/ld"
	export PATH="$NATIVEPREFIX/bin:$PATH"
	
	case $product in
	libelf)
	    CFLAGS="$CFLAGS -fPIC"
	    ;;
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
		CFLAGS="-I$NATIVEPREFIX/gcc-$GCC_VERSION/include $CFLAGS"
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
