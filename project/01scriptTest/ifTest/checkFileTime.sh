#!/bin/bash

dirname='./secrets/*'


for file in $dirname
do
    for file2 in $dirname
    do
        if [ $file = $file2 ]
        then
            continue
        fi
        # echo $file" -  VS - "$file2
        if [ ! $ans ]
        then
            ans=$file
        fi
        if [ $ans -ot $file2 ]
        then
            ans=$file2
        fi
    done
done
echo "$ans is the newest!"
