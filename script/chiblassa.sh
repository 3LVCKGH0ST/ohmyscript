#! /bin/bash

SCRDIR="$PWD/script"

TOKEN=$((ls | grep -q "debug_token" && cat $SCRDIR/debug_token || $SCRDIR/mytoken) | grep cookie)

TOSEATCHNAME=""
while getopts 'n:' OPTION; do
  case "$OPTION" in
    n)
      TOSEATCHNAME=$OPTARG
      ;;
    ?)
      echo "script usage: $(basename \$0) [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

CLUSTER=$(echo $1 | tr '[:upper:]' '[:lower:]')

if [[ $CLUSTER == "" ]]; then
	CLUSTER="e"
fi

UNAVAILABLE=$(curl --max-time 3 --silent "https://meta.intra.42.fr/clusters.json" \
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
  --compressed | tr "},{" "\n" | grep $CLUSTER | tr ":" "\n" | grep $CLUSTER | tr "\n" ",")

if [[ "e1" == "$CLUSTER" ]]; then
	E1CLUSTER=$(curl --max-time 3 --silent "https://cdn.intra.42.fr/cluster/image/36/bg_e1.svg" | tr "id=" "\n" | grep "e1" | awk '{print $1}' | tr "\"\n" "\",\n")
	AVAILABLE=$(python -c "cluster = [$E1CLUSTER]; unavailable = [$UNAVAILABLE]; print('\n'.join(map(str, list(set(cluster) - set(unavailable)))))")
  python -c "myarr = [$UNAVAILABLE];
for x in range(13,0,-1):print(''+ ('              ___      ___      ___' if x != 7 else '                                   ') + '           ___      ___      ___	\n' + ('	 ____|   |____|   |____|   |' if x != 7 else '	                           ') + '	 ____|   |____|   |____|   |\n' + ('	|    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p11' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p9' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p7' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |	' if (x != 7) else '                                        ') +'|    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p5' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p3' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p1' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |     R'+str(x)+'\n' + ('	|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p12' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p10' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p8' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|' if x!=7 else '                                 ') + '	|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p6' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p4' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e1r'+str(x)+'p2' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|\n' + ('	|____|   |____|   |____|    ' if x!= 7 else '                                    ')+'    |____|   |____|   |____|')"
  if [[ $test -ge 0 ]] && [[ $test -le 14 ]]; then
    echo $AVAILABLE | tr " " "\n" | grep "r$2p";
  fi
  echo -e "\n  $(echo $AVAILABLE | tr " " "\n" | wc -l) vacant posts.";
elif [[ "e2" == "$CLUSTER" ]]; then
	E1CLUSTER=$(curl --max-time 3 --silent "https://cdn.intra.42.fr/cluster/image/37/bg_e2.svg" | tr "id=" "\n" | grep "e2" | awk '{print $1}' | tr "\"\n" "\",\n")
	AVAILABLE=$(python -c "cluster = [$E1CLUSTER]; unavailable = [$UNAVAILABLE]; print('\n'.join(map(str, list(set(cluster) - set(unavailable)))))")
  python -c "myarr = [$UNAVAILABLE];
for x in range(13,0,-1):print(''+ ('              ___      ___      ___' if x != 7 else '                                   ') + '           ___      ___      ___	\n' + ('	 ____|   |____|   |____|   |' if x != 7 else '	                           ') + '	 ____|   |____|   |____|   |\n' + ('	|    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p11' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p9' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p7' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |	' if (x != 7) else '                                        ') +'|    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p5' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p3' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |    | '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p1' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |     R'+str(x)+'\n' + ('	|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p12' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p10' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p8' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|' if x!=7 else '                                 ') + '	|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p6' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p4' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|  '+ ('"$(tput setaf 9)"X"$(tput setaf 7)"' if 'e2r'+str(x)+'p2' in myarr else '"$(tput setaf 28 214 121)"√"$(tput setaf 7)"') +' |___|\n' + ('	|____|   |____|   |____|    ' if x!= 7 else '                                    ')+'    |____|   |____|   |____|')"
  echo -e "\n  $(echo $AVAILABLE | tr " " "\n" | wc -l) vacant posts.";
else
  if [[ $TOSEATCHNAME != "" ]];then
    JSON=$(curl --max-time 3 --silent "https://meta.intra.42.fr/clusters.json" \
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
    --compressed | tr "},{" "\n" | grep -n "\"login\":\"$TOSEATCHNAME\"" | head -n1 | cut -d : -f1);
    if [[ $JSON != "" ]];then
      FIND=$(curl --max-time 3 --silent "https://meta.intra.42.fr/clusters.json" \
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
      --compressed | tr "},{" "\n" | head -n$(expr $JSON - 3) | tail -n1 | cut -d : -f2);
      echo $TOSEATCHNAME Currently on : $FIND;
    else
      echo $TOSEATCHNAME Currently Not available;
    fi
  fi
fi