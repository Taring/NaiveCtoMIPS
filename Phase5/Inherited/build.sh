#!/bin/bash

for source in `ls *.c`; do
	name=${source%.c}
	rm -f /tmp/program
	gcc -m32 $source -o /tmp/program 2>&1
	if [ -f /tmp/program ]; then
		cn=${source%.c}
		echo now outputing to ${cn}.ans
		if [ -f Inherited-InputSet/$cn.in ]; then
			time /tmp/program < Inherited-InputSet/$cn.in > Inherited-AnswerSet/$cn.ans
		else
			time /tmp/program > Inherited-AnswerSet/$cn.ans
		fi
	fi
done
