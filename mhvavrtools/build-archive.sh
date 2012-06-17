date="`date +%Y%m%d`"

if [ `uname -m` = 'i686' ]; then
	7za a -m0=lzma -mx=9 -md=64m -sfx mhvavrtools-linux_x86-$date.runme mhvavrtools/
else
	if [ `uname` = 'Darwin' ]; then
		7za a -m0=lzma -mx=9 -md=1024m -sfx mhvavrtools-linux_x64-$date.runme mhvavrtools/
	else
		7za a -m0=lzma -mx=9 -md=1024m -sfx mhvavrtools-osx_x64-$date.runme mhvavrtools/
	fi
fi

