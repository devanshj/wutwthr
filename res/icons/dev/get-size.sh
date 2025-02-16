rows=$(cat $1 | wc -l)
rows=$(($rows+1))
cols=$(head -1 $1 | wc -m)
cols=$(($cols-1))
echo "$rows $cols"
