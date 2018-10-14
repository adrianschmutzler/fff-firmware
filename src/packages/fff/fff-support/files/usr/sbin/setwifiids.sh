#!/bin/sh
# This sets a custom essid for AP (1st arg) and Mesh (2nd arg),
# resetting each to standard if not provided (no args=full reset)
#
# Supports only 802.11s mesh ID (no AdHoc)

. /lib/functions/fff/keyxchange

essid=$1
mesh_id=$2

uci -q set "fff.wifi=fff"
uci -q delete "fff.wifi.essid"
uci -q delete "fff.wifi.mesh_id"

[ -n "$essid" ] && uci -q set "fff.wifi.essid=$essid"
[ -n "$mesh_id" ] && uci -q set "fff.wifi.mesh_id=$mesh_id"
uci -q commit fff

rm -f "$hoodfileref" # delete this, so settings will be applied during next run of configurehood
