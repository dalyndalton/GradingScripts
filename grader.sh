#!/usr/bin/env bash

# Grab arguments
file=$1
# Grab input file if provided, else assumed to be ./input.txt
if [ -v $2 ]; then
    input="input.txt"
else
    input=$2
fi
input=$2
# set exec and err vars
exec=${file%.*}.out
err=${file%.*}.txt
# Removes previous error file if it exists
rm $err 2> /dev/null

# Check for 80 character limit
cat $file | while read line; do
    count=$(echo $line | wc -c)
    if [ $count -gt 81 ]; then
        echo -e "\033[0;33mLine exceeds 80 characters"
        break
    fi
done

# compile using gcc
# only displays erros in compiling
gcc $file -o $exec >/dev/null 2>>$err
# Run program
cat $input | ./$exec $input 2>>$err

# clean up
rm $exec 2> /dev/null

# delete errors if empty
RED='\033[0;31m'
GREEN='\033[0;32m'
if [ -s $err ]; then
    echo -e "\e[31mErrors located in $err"
else
    echo -e "\n\033[0;32m$file compiled and ran sucessfully"
    rm $err
fi
