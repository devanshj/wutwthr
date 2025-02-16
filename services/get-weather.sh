latLong=$1
weatherRes=$(curl -s "https://api.darksky.net/forecast/2b8063d58ed6137072c531f072a843eb/$latLong?units=si")
declare -A weather

keys=(
    apparentTemperature
    cloudCover
    dewPoint
    humidity
    icon
    ozone
    precipIntensity
    precipProbability
    pressure
    summary
    temperature
    time
    uvIndex
    visibility
    windBearing
    windGust
    windSpeed
)


for key in ${keys[@]}; do
    regex='"currently":{.[^}]*"'$key'":(.[^,}]*)'
    if [[ $weatherRes =~ $regex ]]; then
        weather[$key]=${BASH_REMATCH[1]}
    else
        weather[$key]=""
    fi
done;

daySummaryRegex='"hourly":.*{"summary":"(.[^,]*)"'
if [[ $weatherRes =~ $daySummaryRegex ]]; then
    weather["daySummary"]=$(echo '"'${BASH_REMATCH[1]}'"')
else
    weather["daySummary"]=""
fi

echo -n "( "
for key in "${!weather[@]}"; do
    echo -n "[$key]=${weather[$key]} "
done
echo -n ")"
