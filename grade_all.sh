#!/bin/bash 

# Get command line args
PATH=$1
INPUT_FILE=$2
OUTPUT=$(/tmp/outputfile)

for file in "$PATH"/*.c
do
    # Get line length
    cat $file | while read line; do
        length= $(wc $line -c] -gt)
        if [$length -gt 80]; then
            "Line exceeds 80 characters \n" >> $OUTPUT
        fi
   
    # compile programs
    EXEC="${FILE%.*}.out"
    EXIT=$(gcc $file -o $EXEC)
    

done