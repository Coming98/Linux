#!/bin/bash


#!/bin/bash


exec 9<&0
exec 0<"input.txt"
IFS_OLD=$IFS
IFS=,

while read name age gender
do
    info="Hello $name, you are $age year's old, you sex is $gender"
    if [ $name = "cjc" ]; then
        echo $info | tee -a "cjc.info" 
        echo $info | tee -a "cjc.info" 
        echo $info | tee -a "cjc.info" 
        echo $info | tee -a "cjc.info" 
        echo $info | tee -a "cjc.info" 
        echo $info | tee -a "cjc.info" 
        echo $info | tee -a "cjc.info" 
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
echo "name=$name, password=$password" | tee -a "cjc.info"


echo "this is an advertisment" | tee -a /dev/null
