file=$1
row=$2
col=$3
if [ "$2" == "" ]
then
    declare -a curPos=$(utils/get-cur-pos.sh)
    row=${curPos[0]}
    col=${curPos[1]}
fi

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo -en "\E["$row";"$col"H"
    echo -n "$line"
    if (( $(tput lines) != $row - 1)); then
        row=$(( $row + 1 ))
    fi
done < $file