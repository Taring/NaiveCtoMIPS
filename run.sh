#!/bin/bash
set -x
#Note that chinese name of directory may not be supported.
make clean
make all

#prepare outputs directory
mkdir -p outputs && rm outputs/*

source midtermvars.sh
for i in $(ls Phase2/CompileError); do
	cp Phase2/CompileError/$i bin/data.c
	cd bin
	$CCHK data.c > ../outputs/${i%.*}.s
	echo "exiting status : $?"
	cd ..
done

for i in $(ls Phase2/CompileError-new); do
	cp Phase2/CompileError-new/$i bin/data.c
	cd bin
	$CCHK data.c > ../outputs/${i%.*}.s
	echo "exiting status : $?"
	cd ..
done

for i in $(ls Phase2/Passed); do
	cp Phase2/Passed/$i bin/data.c
	cd bin
	$CCHK data.c > ../outputs/${i%.*}.s
	echo "exiting status : $?"
	cd ..
done

for i in $(ls Phase2/Passed-new); do
	cp Phase2/Passed-new/$i bin/data.c
	cd bin
	$CCHK data.c > ../outputs/${i%.*}.s
	echo "exiting status : $?"
	cd ..

done


