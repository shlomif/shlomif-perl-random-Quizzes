#!/bin/bash

TARGET="./dist"
if [ -e "$TARGET" ] ; then
    rm -fr $TARGET
fi

VER=`cat ver.txt`

mkdir $TARGET
cp lm-solve COPYING MANIFEST TODO INSTALL README $TARGET
cat Makefile.PL | sed 's/\[\[VERSION\]\]/'"$VER"'/' > $TARGET/Makefile.PL
cat lm-solve.spec.in | sed 's/\[\[VERSION\]\]/'"$VER"'/' > $TARGET/lm-solve.spec
mkdir $TARGET/lib
cp -r Shlomif $TARGET/lib
(
    cd $TARGET
    perl Makefile.PL
    make dist
    cp LM-Solve-* ../
)
rm -fr $TARGET
