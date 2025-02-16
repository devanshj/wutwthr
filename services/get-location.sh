place=$1
latLong=""
if [ "$place" = "" ]; then
	locRes=$(curl -s https://ipapi.co/json/)
	locRegex='"city":\s*"([a-zA-Z]*)".*"latitude":\s*(-?[0-9\.]*).*"longitude":\s*(-?[0-9\.]*)'
	if [[ $locRes =~ $locRegex ]]; then
		place=${BASH_REMATCH[1]}
		latLong="${BASH_REMATCH[2]},${BASH_REMATCH[3]}"
	fi
else
	latLongRes=$(curl -s "https://us1.locationiq.com/v1/search.php?key=15d83a204fc87a&limit=1&format=json&q=$place")

	latLongRegex='"lat":"((-|[0-9]|\.)*)".*"lon":"((-|[0-9]|\.)*)"'
	if [[ $latLongRes =~ $latLongRegex ]]; then
		latLong=${BASH_REMATCH[1]},${BASH_REMATCH[3]}
	fi

	placeRegex='"display_name":"(.[^"]*)"'
	if [[ $latLongRes =~ $placeRegex ]]; then
		place=${BASH_REMATCH[1]}
	fi
fi
echo '( [place]="'$place'" [latLong]='$latLong' )'