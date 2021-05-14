#!/bin/bash


exec 9<&0
exec 0<"input.txt"
IFS_OLD=$IFS
IFS=,

while read name age gender
do
    info="Hello $name, you are $age year's old, you sex is $gender"
    if [ $name = "cjc" ]; then
        exec 3>&1
        exec 1> "cjc.info"
        echo $info 
        echo $info 
        echo $info 
        echo $info
        echo $info 
        echo $info 
        exec 1>&3
        exec 3>&-
    else
        echo $info
    fi
done

exec 0<&9
exec 9<&-
IFS=$IFS_OLD

read -p "username: " name
read -s -p "password: " password
echo 
echo "name=$name, password=$password"


echo "this is an advertisment" > /dev/null
