#!/bin/bash


filename='a.txt'

IFS_OLD=%IFS
IFS=','

cat $filename | while read line
do
    for var in $line
    do
        echo -n "$var : "
    done
    echo -e "\n========================"
done

while read line
do
    for var in $line
    do
        echo -n "$var : "
    done
    echo -e '\n============================'
done < $filename


IFS=$IFS_OLD
