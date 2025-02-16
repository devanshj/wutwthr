sizesFile=$(dirname "$0")/../char-widths.sh
>$sizesFile
echo "echo -n '( '" | tee --append $sizesFile
for char in $(ls $(dirname "$0")/../*.txt); do
    charName=$(basename $char .txt)
    charSize=$($(dirname "$0")/get-char-width.sh $char)
    echo "echo -n '[\""$charName"\"]="$charSize" '" | tee --append $sizesFile
done
echo "echo -n ' )'" | tee --append $sizesFile