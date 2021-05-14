#!/bin/bash

trap "echo ' haha you can not kill me!'" SIGINT
trap "echo ' exit successfully'" EXIT

count=1
while [ $count -le 10 ]
do
    echo "epoch $count"
    count=$[ $count + 1 ]
    sleep 1
done
