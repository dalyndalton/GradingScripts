#!/usr/bin/env bash

# Grab arguments
file=$1
# Grab input file if provided, else assumed to be ./input.txt
if [ -z "$2" ]; then
    input="input.txt"
else
    input=$2
fi
# set exec and err vars
exe=${file%.*}.out
err=${file%.*}.txt
# Removes previous error file if it exists
rm $err 2> /dev/null



# compile using gcc
# only displays erros in compiling
gcc "$file" -o "$exe" >/dev/null 2>>"$err" -lm
# Run program
cat "$input" | "./$exe" 2>>"$err"

# clean up
rm "$exe" 2> /dev/null

# delete errors if empty
RED='\033[0;31m'
GREEN='\033[0;32m'

if [ -s "$err" ]; then
    echo -e "\e[31mErrors located in $err"
else
    echo -e "\n\033[0;32m$file compiled and ran sucessfully"
    rm "$err"
fi

# Check for 80 character limit
cat "$file" | while read line; do
    count=$(echo $line | wc -c)
    if [ $count -gt 81 ]; then
        echo -e "\033[0;33mLine exceeds 80 characters"
        break
    fi
done