#!/bin/bash

echo "to iter the input params"

param_idx=1
while [ -n "$1" ]
do
    echo "Params #$param_idx = $1"
    param_idx=$[ $param_idx + 1 ]
    shift 2
done
