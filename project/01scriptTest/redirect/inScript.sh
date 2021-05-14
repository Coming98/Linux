
#!/bin/bash

exec 2>"wrong.txt"
exec 1>"output.txt"

echo "This is an error" >&2
echo "This is normal output"

exec 0< "input.txt"

IFS_OLD=$IFS
IFS=,

while read name age gender
do
    echo "Hello $name, you are $age year's old, you sex is $gender"
done

IFS=$IFS_OLD
