$( basename $0 )
#sename $0 )
!/bin/bash

script_name=$( basename $0 )

echo "================================"
echo "File Name: $script_name"
echo "Count of parameters: $#"
echo "the last parameter: ${!#}"
echo "\$* the whole parameters: $*"
echo "\$@ the whole parameters: $@"
echo "the details of parameters:"
param_idx=1
for var in $@
do
    echo "parameter #$param_idx = $var"
    param_idx=$[ $param_idx + 1]
done
echo "================================"
echo "multipul test"

if [ $# -ne 4 ]
then
    echo "wrong input:at least 4 parameters"
    exit 0
fi

ans=$[ $1 * $2 ]

echo "result = $ans"

echo "say hello - space in input parameter"

echo "hello $3"
echo "hello $4"

echo "check if user input correct parameters"

if [ -z "$5" ]
then
    extra_info="none"
else
    extra_info=$5
fi

echo "extra info? >>> $extra_info"
