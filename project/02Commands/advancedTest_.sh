#!/bin/bash

var=1

if (( $var ** 4 == 1 ))
then
    # (( var = var++ ))
    (( var2 = var++ ))
    echo $var
    echo $var2
else
    echo "permission denies"
fi

echo "new line"
var=6
if (( $var >= 10 || $var <= 5 ))
then
    echo "var = $var"
fi

echo "wildcard test"
echo "only output .sh"
for file in ./*
do
    if [[ $file == *.sh ]]
    then
        echo $file
    fi
done
