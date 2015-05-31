#!/bin/bash
set -x
#Note that chinese name of directory may not be supported.
export CCHK="java -classpath ../java-cup-11b-runtime.jar:../bin Main" 

make clean
make all

#prepare outputs directory
mkdir -p outputs && rm outputs/*

for i in $(ls Phase5/Test-Passed); do
    cp Phase5/Test-Passed/$i bin/data.c
    cp Phase5/InputSet/${i%.*}.in bin/data.in
    cp Phase5/AnswerSet/${i%.*}.ans bin/data.ans
    cd bin
    $CCHK < data.c > data.s
    cp data.s ../outputs/${i%.*}.s
    if [ -f data.in ]; then
        spim -f data.s < data.in > data.out
    else
        spim -f data.s > data.out
    fi
    diff data.ans data.out
    if [ $? -eq 0 ];
        then 
        echo $i 
        else
        break;
    fi
    cd ..
done

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