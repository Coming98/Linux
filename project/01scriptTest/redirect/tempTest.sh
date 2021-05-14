#!/bin/bash

tempfile=$( mktemp demotemp.XXXXXX )

exec 3>&1
exec 1>$tempfile

echo "temp information"

exec 1<&3
exec 3>&-

echo "normal information"
rm -f $tempfile 2> /dev/null

tempdir=$(mktemp -d dir.XXXXXX)
cd $tempdir
tempfile1=$( mktemp temp.XXXXXX )
tempfile2=$( mktemp temp.XXXXXX )

exec 3>$tempfile1
exec 4>$tempfile2

echo "normal 2"
echo "temp1" >&3
echo "temp2" >&4 

exec 3>&-
exec 4>&-
cd ..
rm -rf $tempdir 2> /dev/null
