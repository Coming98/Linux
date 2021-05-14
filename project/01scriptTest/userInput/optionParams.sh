#!/bin/bash

echo
while [ -n "$1" ]
do
    case "$1" in
    -a) echo "Found the $1 option" ;;
    -b) param=$2
        echo "Found the $1 option"
        echo "  with the parameter value $param"
        shift;;
    -c) echo "Found the $1 option" ;;
    --) shift
        break;;
    *) echo "$1 is an wrong option" ;;
    esac
    shift
done

param_idx=1
for param in $@
do
    echo "Parameter #$param_idx = $param"
    param_idx=$[ $param_idx + 1 ]
done
