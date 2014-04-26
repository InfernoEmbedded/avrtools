#!/bin/sh

set -x
set -e

#CFLAGS="-mthreads -Wall -O2 -I. -I./glob -I./w32/include -I/mingw/include -DWINDOWS32 -DHAVE_CONFIG_H"
CFLAGS="-mthreads -Wall -O2 -gdwarf-2 -g3 -I. -I./glob -I./w32/include -DWINDOWS32 -DHAVE_CONFIG_H"
cp config.h.W32 config.h

gcc $CFLAGS -c variable.c
gcc $CFLAGS -c rule.c
gcc $CFLAGS -c remote-stub.c
gcc $CFLAGS -c commands.c
gcc $CFLAGS -c file.c
gcc $CFLAGS -c getloadavg.c
gcc $CFLAGS -c default.c
gcc $CFLAGS -c signame.c
gcc $CFLAGS -c expand.c
gcc $CFLAGS -c dir.c
gcc $CFLAGS -c main.c
gcc $CFLAGS -c getopt1.c
gcc $CFLAGS -c job.c
gcc $CFLAGS -c output.c
gcc $CFLAGS -c read.c
gcc $CFLAGS -c version.c
gcc $CFLAGS -c getopt.c
gcc $CFLAGS -c arscan.c
gcc $CFLAGS -c remake.c
gcc $CFLAGS -c hash.c
gcc $CFLAGS -c strcache.c
gcc $CFLAGS -c misc.c
gcc $CFLAGS -c ar.c
gcc $CFLAGS -c function.c
gcc $CFLAGS -c vpath.c
gcc $CFLAGS -c implicit.c
gcc $CFLAGS -c loadapi.c
gcc $CFLAGS -c load.c
gcc $CFLAGS -c ./glob/glob.c -o glob.o
gcc $CFLAGS -c ./glob/fnmatch.c -o fnmatch.o
gcc $CFLAGS -c ./w32/pathstuff.c -o pathstuff.o
gcc $CFLAGS -c ./w32/compat/posixfcn.c -o posixfcn.o

gcc -mthreads -gdwarf-2 -g3 -o $PREFIX/bin/make.exe variable.o rule.o remote-stub.o commands.o file.o getloadavg.o default.o signame.o expand.o dir.o main.o getopt1.o job.o output.o read.o version.o getopt.o arscan.o remake.o misc.o hash.o strcache.o ar.o function.o vpath.o implicit.o loadapi.o load.o glob.o fnmatch.o pathstuff.o posixfcn.o w32_misc.o sub_proc.o w32err.o -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -luuid -lodbc32 -lodbccp32 -Wl,--out-implib=libgnumake-1.dll.a