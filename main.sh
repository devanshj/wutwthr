shDir=$(dirname "$0")

# ================================
# Print Logo

declare -a curPos=$($shDir/utils/get-cur-pos.sh)
$shDir/utils/print.sh $shDir/res/logo.txt ${curPos[0]} $((${curPos[1]} + 2))
echo -ne "\n\n"


# ================================
# Print place & lat-long

inputPlace=$*
latLong=""

if [ "$inputPlace" = "" ]; then
	echo -n "  Fetching current location..."
else
	echo "  $inputPlace"
	echo -n "  Fetching latitude and longitude..."
fi

declare -A loc=$($shDir/services/get-location.sh "$inputPlace")
place=${loc["place"]}
latLong=${loc["latLong"]}
echo -ne "\n\E[1A\E[2K"

if [ "$inputPlace" != "" ]; then
	echo -ne "\E[1A"
fi

echo "  $place"

if [[ "$latLong" == "" ]]; then
	echo -ne "\E[1A"
	echo -ne "\E[2K"
	echo "  $place not found."
	echo -ne "\n"
	exit
fi

echo "  $latLong"

# ================================
# Print weather

echo -ne "\n  Fetching weather data..."
declare -A weather=$($shDir/services/get-weather.sh $latLong)
echo -ne "\E[2K"
echo -ne "\n"
echo -ne "\E[1A"

# -------------
# icon

icon=${weather[icon]}
declare -A iconSizes=$($shDir/res/icons/sizes.sh)
declare -a iconSize=(${iconSizes[$icon]})

echo -ne "\E[2C"
$shDir/utils/print.sh res/icons/$icon.txt

# -------------
# tempature
declare -a curPos=$($shDir/utils/get-cur-pos.sh)
echo -ne "\E["$((${iconSize[0]} - 1))"A"
if (( $iconSize < 4 )); then
	echo -ne "\E[1A"
fi
echo -ne "\E[2C"
$shDir/res/small-font/write.sh $(printf %.0f ${weather[temperature]})"dC"

# -------------
# details
echo -ne "\n\n"
if (( ${iconSize[0]} > 4 )); then
	echo -ne "\n"
fi

echo "  Currently ${weather[summary]}."
if [[ "${weather[daySummary]}" != "" ]]; then
	echo "  ${weather[daySummary]}"
fi
echo -ne "\n"
echo "  Precipition: $($shDir/utils/calc.sh 100*${weather[precipProbability]})%"
echo "  Humidity: $($shDir/utils/calc.sh 100*${weather[humidity]})%"
echo "  Wind: ${weather[windSpeed]} m/s"
echo -ne "\n"