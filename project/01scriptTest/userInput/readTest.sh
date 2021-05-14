#!/bin/bash 

read name
echo "Hello $name"

message="input your name please...."
read -p "$message" name1
echo "Hello $name1"

if read -t 5 -p "your name please >>> " name2 
then
    echo "hello $name2"
else
    echo
    echo "too slow"
    echo "system closed"
fi

read -p "raed again >>> " -n3 name3
echo 
echo "suprise hello $name3"

read -p "password please ... " -s passwd
echo
echo "your passwd is $passwd"
