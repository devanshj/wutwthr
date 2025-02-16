cols=$(head -1 $1 | wc -m)
cols=$(($cols-1))
echo "$cols"