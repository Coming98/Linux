#!/bin/bash

filename='default.config'

if [ -f $filename ]
then
    echo "$filename is existed"
    if [ -r $filename ]
    then
        echo "$filename is readable"
    else
        echo "$filename is not readable"
    fi
    if [ -x $filename ]
    then
        echo "$filename is executable"
    else
        echo "$filename is not executable"
    fi
else
    echo "$filename is not existed"
fi
