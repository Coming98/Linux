#!/bin/bash

IFS_OLD=$IFS
IFS=:

for path in $PATH
do
    echo $path
    if [ -d $path ]
    then
        for filepath in $path/*
        do
            if [ -x $filepath ]
            then
                echo "  $filepath is executable"
            fi
        done
    fi
done

IFS=$IFS_OLD
