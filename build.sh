#!/bin/bash

files=$(find `pwd` -name "*.chpl" -printf "%p\n" | sort)

for i in ${files[@]}; do
   echo -ne "\ncompiling ${i##*/} as ${i%.*}\n"
   chpl -o ${i%.*} ${i} --fast
done