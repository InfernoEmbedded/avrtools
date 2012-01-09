#!/bin/sh

. ./config.sh

echod "Installing GNU CoreUtils ${GNUCORE_UTILS_VERSION}"

unzip -o download/coreutils-${GNU_COREUTILS_VERSION}-bin.zip -d $PREFIX
unzip -o download/coreutils-${GNU_COREUTILS_VERSION}-dep.zip -d $PREFIX

echod "Done building GNU CoreUtils ${GNUCORE_UTILS_VERSION}"
