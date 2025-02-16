declare -A widthOfChar=$($(dirname "$0")/char-widths.sh)

str=$1
row=$2
col=$3
dir=$(dirname "$0")

for (( i=0; i < ${#str}; i++ )); do
    char=${str:$i:1} 
    charWidth=${widthOfChar[$char]}
    
    if (( i == 0)); then
        utils/print.sh $dir/$char.txt $row $col
    else
        echo -ne "\E[3A"
        utils/print.sh $dir/$char.txt
    fi
done