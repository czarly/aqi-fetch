DIR=$PWD

FILE=$DIR/logs
if [ ! -f "$FILE" ]; then
    mkdir -p $DIR/logs
fi

FILENAME=$DIR/logs/$(date +"%Y_%m_%d_%I_%M_%p").csv

echo "LAT;LON;TIME;URL;AQI;CO;DEW;H;NO2;O3,P;PM10;PM25;R;SO2;T;W" >> $FILENAME

while read p; do

    tempfile=$(mktemp)
    #temp_file=$(mktemp -d "${TMPDIR:-/tmp}aqiscan.XXXXXXXXX")

    curl --silent "https://api.waqi.info/feed/geo:$p/?token=3808ecb3be8de9d8a8c0d40d7316644e1163902e" >> $tempfile

    #echo $(cat $tempfile | jq '.data .iaqi')

    LAT=$(cat $tempfile | jq '.data .city .geo[0]')
    LON=$(cat $tempfile | jq '.data .city .geo[1]')
    TIME=$(cat $tempfile | jq '.data .time .s')
    URL=$(cat $tempfile | jq '.data .city .url')
    AQI=$(cat $tempfile | jq '.data .iaqi .aqi .v')
    CO=$(cat $tempfile | jq '.data .iaqi .co .v')
    DEW=$(cat $tempfile | jq '.data .iaqi .dew .v')
    H=$(cat $tempfile | jq '.data .iaqi .h .v')
    NO2=$(cat $tempfile | jq '.data .iaqi .no2 .v')
    O3=$(cat $tempfile | jq '.data .iaqi .o3 .v')
    P=$(cat $tempfile | jq '.data .iaqi .p .v')
    PM10=$(cat $tempfile | jq '.data .iaqi .pm10 .v')
    PM25=$(cat $tempfile | jq '.data .iaqi .pm25 .v')
    R=$(cat $tempfile | jq '.data .iaqi .r .v')
    SO2=$(cat $tempfile | jq '.data .iaqi .s02 .v')
    T=$(cat $tempfile | jq '.data .iaqi .t .v')
    W=$(cat $tempfile | jq '.data .iaqi .w .v')

    echo "$LAT,$LON,$TIME,$URL,$AQI,$CO,$DEW,$H,$NO2,$O3,$P,$PM10,$PM25,$R,$SO2,$T,$W" | sed 's/null//g' >> $FILENAME

    rm ${tempfile}
	
done <stations.lst
