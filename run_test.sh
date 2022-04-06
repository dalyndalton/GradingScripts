# Grab arguments
exe=$1

# Grab input file if provided, else assumed to be ./input.txt
if [ -z "$2" ]; then
    input="./input.txt"
else
    input=$2
fi

cat "$input" | while read line; do
    echo "$line" | "./$exe" 2>&1
    echo ""
done