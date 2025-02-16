sizesFile=$(dirname "$0")/../sizes.sh
>$sizesFile
echo "echo -n '( '" | tee --append $sizesFile
for icon in $(ls $(dirname "$0")/../*.txt); do
    iconName=$(basename $icon .txt)
    iconSize=$($(dirname "$0")/get-size.sh $icon)
    echo "echo -n '[\""$iconName"\"]=\""$iconSize"\" '" | tee --append $sizesFile
done
echo "echo -n ' )'" | tee --append $sizesFile