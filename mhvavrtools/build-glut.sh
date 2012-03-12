#!/bin/sh

. ./config.sh

cd build || \
	die "Could not CD to build"

echod "Installing GLUT ${GLUT_VERSION}"

cp glut-${GLUT_VERSION}-bin/glut32.dll $PREFIX/bin
cp glut-${GLUT_VERSION}-bin/glut32.lib $PREFIX/lib
cp glut-${GLUT_VERSION}-bin/glut.def $PREFIX/lib
mkdir $PREFIX/include/GL
cp glut-${GLUT_VERSION}-bin/glut.h $PREFIX/include/GL

echod "Done building GLUT ${GLUT_VERSION}"
