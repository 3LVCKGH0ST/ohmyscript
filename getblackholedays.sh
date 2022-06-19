#! /bin/bash

BLACKHOLESF=$(cat out | grep "emote-bh" | grep "title" | awk '{print $NF}' | tr "'" " " | awk '{print $2}' | tr '/' '-');
BLACKHOLE=$(awk -F'-' '{printf("%04d-%02d-%02d\n",$3,$2,$1)}' <<< $BLACKHOLESF | tr '-' ',')

echo "";
echo -n -e $BLACKHOLESF ' \t\t\t\t\t\t\t\t\t ';python -c "from datetime import date; print (date($BLACKHOLE)-date(2022,06,17)).days, \" days left\";";