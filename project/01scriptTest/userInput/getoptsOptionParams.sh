#!/bin/bash

# getopt :opstring parameters -- ignore fault

echo "getopts opstring parametername"
echo "\$OPTARG means the extra parameter"
echo "\$OPTIND means the parameter idx processing now"

echo
while getopts :ab:cd opt
do
    case "$opt" in
    a) echo "Found the $opt option" ;;
    b) param=$OPTARG
       echo "Found the $opt option"
       echo "  with the parameter value $param";;
    c) echo "Found the $opt option" ;;
    d) echo "Found the $opt option" ;;
    *) echo "$opt is an wrong option" ;;
    esac
done

echo "stop when attach the position parametter"

shift $[ $OPTIND - 1 ]

param_idx=1
for param in "$@"
do
    echo "Parameter #$param_idx = $param"
    param_idx=$[ $param_idx + 1 ]
done
