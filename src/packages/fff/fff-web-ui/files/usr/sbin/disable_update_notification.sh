#!/bin/sh
# This disables the WebUI update notification permanently
# (until next firmware upgrade)

uci -q set "fff.notifyupdate=webui"
uci -q set "fff.notifyupdate.value=0"
uci -q set "fff.notifyupdate.resetonupgrade=1"
uci -q commit fff

/bin/rm -f /tmp/isupdate
/bin/rm -f /tmp/fwcheck
