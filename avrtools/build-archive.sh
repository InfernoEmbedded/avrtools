date="`date +%Y%m%d`"

if [ `uname -m` = 'i686' ]; then
	7za a -m0=lzma -mx=9 -md=64m -sfx inferno-avrtools-linux_x86-$date.runme avrtools/
else
	if [ `uname` = 'Darwin' ]; then
		7za a -m0=lzma -mx=9 -md=1024m -sfx inferno-avrtools-osx_x64-$date.runme avrtools/
	else
		7za a -m0=lzma -mx=9 -md=1024m -sfx inferno-avrtools-linux_x64-$date.runme avrtools/
	fi
fi

