#!/bin/sh
cd /tmp/

. /etc/adsc.cfg

[ $# -gt "0" ] && cat=$1 || cat="$CATEGORY"
[ $# -gt "1" ] && board=$2

localname="/tmp/sysup-adsc.sh"

wget "${UPGRADE_PATH}getups.php?cat=$cat" -O "$localname"
chmod +x "$localname"
"$localname" $cat $board
