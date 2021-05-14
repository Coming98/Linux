#!/bin/bash
var=10

if [ $var -eq 10 ]
then
    echo "equal!"
fi

str1='cjc'
str2='cjc'

echo "注意=两边需要空格"

if [ $str1 = $str2 ]
then
    echo "str equal!"
    echo $str1
    echo $str2
    echo $cjc
else
    echo "str not equal!"
fi


echo "简单的str大小比较需要转义 > <"
str1='cjca'
str2='cjac'
if [ $str1 \> $str2 ]
then
    echo "$str1 > $str2"
else
    echo "$str1 < $str2"
fi

echo "check str length is zero?"
str1=""
str2="11"
if [ -n $str2 ]
then
    echo "$str2 is not zero"
fi
if [ -z $str1 ]
then
    echo "$str1 is zero length"
fi

