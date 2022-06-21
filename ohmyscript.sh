#!/bin/bash

TOKEN=$(cat token | grep cookie)

MONTH=$(date +%m)
echo <<EOF "$(tput setaf 28 214 121)


    █████████       ██████████       ██████████        ███████████
    ██     ██               ██               ██        ██       ██ 
           ██               ██               ██        ██       ██
      	   ██               ██               ██                 ██
      	   ██       ██████████       ██████████                 ██
      	   ██               ██               ██                 ██
      	   ██               ██               ██                 ██
      	   ██               ██               ██                 ██
      	 ██████     ██████████       ██████████                 ██ . MA
    
    
                        $(tput setaf 7)<$(tput setaf 7) $(tput setaf 28 214 121)FUTURE:$(tput setaf 7) IS_LOADING />
                                    
                       $(tput setaf 28 214 121)$USER@student.1337.ma$(tput setaf 7)
"
EOF
echo -e "                     $(date)\n";

LOCATION=$(curl --silent "https://profile.intra.42.fr/users/$USER/locations_stats" \
  -H 'authority: profile.intra.42.fr' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: max-age=0' \
  -H  "$TOKEN" \
  -H 'if-none-match: W/"154c76abc67c5627ce61bd65578f0f9d"' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="102", "Google Chrome";v="102"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: none' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36' \
  --compressed)

MYLOCATION=$(echo $LOCATION | grep '{' | tr ',' '\n' | tr '{' ' ' | tr '}' ' ' | grep "\-$MONTH\-")
EXPRTOCALC=$(echo $MYLOCATION | tr ' ' '\n' | tr ':' ' ' | awk '{print $2}' | tr '"' ' ' | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ +/g')

echo -n "My logtime : $(tput setaf 28 214 121)";echo $EXPRTOCALC | bc | tr '\n' ' ';echo "Hours$(tput setaf 7)
";


curl 'https://profile.intra.42.fr/' \
-H 'authority: profile.intra.42.fr' \
-H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
-H 'accept-language: en-US,en;q=0.9' \
-H 'cache-control: max-age=0' \
-H "$TOKEN" \
-H 'if-none-match: W/"154c76abc67c5627ce61bd65578f0f9d"' \
-H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="102", "Google Chrome";v="102"' \
-H 'sec-ch-ua-mobile: ?0' \
-H 'sec-ch-ua-platform: "macOS"' \
-H 'sec-fetch-dest: document' \
-H 'sec-fetch-mode: navigate' \
-H 'sec-fetch-site: none' \
-H 'sec-fetch-user: ?1' \
-H 'upgrade-insecure-requests: 1' \
-H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36' \
--compressed >> out 2>&1;

BGCOLOR=$(cat out | grep progressbar | tail -n1 | awk '{print $NF}' | tr "'" " " | awk '{print $1}');
SGCOLOR="223"

if [[ $BGCOLOR == "#f5bc39" ]];then
  BGCOLOR="223";
  SGCOLOR="220";
elif [[ $BGCOLOR == "#02cdd1" ]];then
  BGCOLOR="195";
  SGCOLOR="51";
elif [[ $BGCOLOR == "#b61282" ]];then
  BGCOLOR="225";
  SGCOLOR="200";
elif [[ $BGCOLOR == "#235a16" ]];then
  BGCOLOR="2";
  SGCOLOR="34";
fi

MYLEVEL=$(cat out | grep "level" | tail -n1 | tr ">" "\n" | tr "<" "\n" | grep level);
PERCENTAGE=$(echo $MYLEVEL | awk '{print substr($NF, 1, length($NF)-1)}');
LEVELCHART=$(python -c "mylevel = '-'.join('' for i in range(59));index = 26;mylevel = mylevel[:index] + '$MYLEVEL' + mylevel[index:];index = $PERCENTAGE*71/100;mylevel = mylevel[:index] + '$(tput setab $BGCOLOR)' + mylevel[index:];print (mylevel)");

echo -e "$(tput setab $SGCOLOR)$(tput setaf 0)$LEVELCHART$(tput sgr0)\n" | tr '-' ' ';

cat out |  grep "project-item " | grep "<a" | tr '>' ' ' | awk '{print $NF}' > outfile;echo -n "$(tput setaf 1)BLACKHOLE : "; ./getblackholedays.sh;echo "
$(tput setaf 28 214 121)PROJECTS :$(tput setaf 7)"; cat outfile; rm -f outfile out;
