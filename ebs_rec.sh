#!/bin/bash

#URL='mms://211.218.209.124/L-FM_300k'
#URL='rtmp://ebsandroid.nefficient.com/fmradiofamilypc/familypc1m'
URL='rtmp://ebsandroid.ebs.co.kr:1935/fmradiofamilypc/familypc1m'
DIR='/home/ebs/mms'
rssDIR='/home/ebs/rss'
DATE=$(/bin/date +%Y%m%d-%H%M)
MIMMS='/usr/bin/mimms'
PRE=$1
TIMELENGTH=$(($2 * 60))
FILENAME_FLV="$DIR/$PRE/$PRE"_"$DATE.flv"
FILENAME_AAC="$DIR/$PRE/$PRE"_"$DATE.m4a"

mkdir "$DIR/$PRE"

echo $FILENAME_AAC $TIMELENGTH

rtmpdump -q -v -r $URL -B $TIMELENGTH -o $FILENAME_FLV
#rtmpdump -v -r $URL -B $TIMELENGTH -o $FILENAME_FLV
/usr/bin/ffmpeg -i $FILENAME_FLV -vn -acodec copy $FILENAME_AAC > /dev/null 2>&1
#/usr/bin/ffmpeg -i $FILENAME_FLV -vn -acodec copy $FILENAME_AAC
rm $FILENAME_FLV

/home/ebs/makePodCast.py $DIR/$PRE > $rssDIR/$PRE.xml
chmod 755 $rssDIR/$PRE.xml
