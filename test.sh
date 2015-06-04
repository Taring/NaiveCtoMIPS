#!/bin/bash
set -x
#Note that chinese name of directory may not be supported.

make clean
make all

cp test.c bin/data.c
cd bin
java -classpath ../java-cup-11b-runtime.jar:../bin Main < data.c > data.s
cp data.s ../test.s
cd ..

#for i in $(ls Phase5/Inherited); do
#	cp Phase5/Inherited/$i bin/data.c
#	cd bin
#    $CCHK < data.c > ../outputs/${i%.*}.s
#	cd ..
#done

#for i in $(ls Phase5/New); do
#	cp Phase5/New/$i bin/data.c
#	cd bin
#    $CCHK < data.c > ../outputs/${i%.*}.s
#	cd ..
#done
