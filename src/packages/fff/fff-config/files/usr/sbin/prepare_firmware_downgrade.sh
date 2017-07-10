#!/bin/sh

if ! grep -q '/etc/config/system' /etc/sysupgrade.conf 2> /dev/null ; then
	echo "/etc/config/system" >> /etc/sysupgrade.conf
fi

if [ -s /etc/config/fff ] ; then
	UPGRADE_hostname=$(uci -q get "fff.system.hostname")
	UPGRADE_description=$(uci -q get "fff.system.description")
	UPGRADE_latitude=$(uci -q get "fff.system.latitude")
	UPGRADE_longitude=$(uci -q get "fff.system.longitude")
	UPGRADE_position_comment=$(uci -q get "fff.system.position_comment")
	UPGRADE_contact=$(uci -q get "fff.system.contact")

	test -n "${UPGRADE_hostname}" && uci -q set "system.@system[0].hostname=${UPGRADE_hostname}"
	test -n "${UPGRADE_description}" && uci -q set "system.@system[0].description=${UPGRADE_description}"
	test -n "${UPGRADE_latitude}" && uci -q set "system.@system[0].latitude=${UPGRADE_latitude}"
	test -n "${UPGRADE_longitude}" && uci -q set "system.@system[0].longitude=${UPGRADE_longitude}"
	test -n "${UPGRADE_position_comment}" && uci -q set "system.@system[0].position_comment=${UPGRADE_position_comment}"
	test -n "${UPGRADE_contact}" && uci -q set "system.@system[0].contact=${UPGRADE_contact}"

	uci -q commit system
fi
