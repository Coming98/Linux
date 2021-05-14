#!/bin/bash

dirname='secrets'

if [ -d $dirname ] && [ -O $dirname -o -G $dirname ]
then
    ls -tr $dirname
else
    echo "permission denied"
fi

