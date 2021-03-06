#!/bin/sh

. ./config.sh

echod "Installing CoreUtils ${COREUTILS_VERSION}"
cd $PREFIX

for file in ../download/coreutils-*.lzma ../download/msysCORE*.lzma; do
        test -e $file || \
                continue
        echod "Extracting $file"
        lzcat $file | tar xf -
done

echod "Done building CoreUtils ${COREUTILS_VERSION}"
