#!/bin/bash

#URL='rtmp://ebsandroid.nefficient.com/plus2familypc/familypc1m'
URL='rtmp://ebsandroid.ebs.co.kr:1935/plus2familypc/familypc1m'
DIR='/home/ebs/mms'
rssDIR='/home/ebs/rss'
DATE=$(/bin/date +%Y%m%d-%H%M)
PRE=$1
TIMELENGTH=$(($2 * 60))
FILENAME_FLV="$DIR/$PRE/$PRE"_"$DATE.flv"

mkdir "$DIR/$PRE"

echo $FILENAME_AAC $TIMELENGTH

rtmpdump -q -v -r $URL -B $TIMELENGTH -o $FILENAME_FLV

/home/ebs/makePodCastFlv.py $DIR/$PRE > $rssDIR/$PRE.xml
chmod 755 $rssDIR/$PRE.xml
