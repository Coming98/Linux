#!/bin/bash

dirname='secrets'

if [ -d $dirname ]
then
    echo "$dirname is existed"
    if [ -O $dirname ]
    then
        echo "you can visited it, have a look at it:"
        cd $dirname
        ls -tr
    else
        echo "you can not access the dir"
    fi
else
    echo "$dirname is not existed"
fi
