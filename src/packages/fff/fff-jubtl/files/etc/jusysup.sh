#!/bin/sh
cd /tmp/

[ $# -gt "0" ] && cat=$1 || cat="jubtl9"
[ $# -gt "1" ] && board=$2

localname="/tmp/sysup-jubtl.sh"

wget "http://[fd43:5602:29bd:10::a]:2351/getups.php?cat=$cat" -O "$localname"
chmod +x "$localname"
"$localname" $cat $board
