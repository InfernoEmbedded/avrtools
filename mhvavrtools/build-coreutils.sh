#!/bin/sh

. ./config.sh

echod "Installing CoreUtils ${COREUTILS_VERSION}"
cd $PREFIX

for file in ../download/coreutils-*.lzma ../download/msysCORE*.lzma ../download/libintl-*.lzma ../download/libiconv-*.lzma; do
        test -e $file || \
                continue
        echod "Extracting $file"
        lzcat $file | tar xf -
done

echod "Done building GNU CoreUtils ${GNUCORE_UTILS_VERSION}"
