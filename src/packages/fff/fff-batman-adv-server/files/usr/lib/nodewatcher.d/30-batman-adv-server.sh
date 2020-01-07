#!/bin/sh
# Netmon Nodewatcher (C) 2010-2012 Freifunk Oldenburg
# License; GPL v3

debug() {
	(>&2 echo "$1")
}

debug "$(date): Collecting information from batman advanced and its interfaces"
#B.A.T.M.A.N. advanced
if [ -f /sys/module/batman_adv/version ]; then
	for iface in $(batctl if | sed 's/ //'); do
		status=${iface##*:}
		iface=${iface%%:*}
		BATMAN_ADV_INTERFACES=$BATMAN_ADV_INTERFACES"<$iface><name>$iface</name><status>$status</status></$iface>"
	done

	echo -n "<batman_adv_interfaces>$BATMAN_ADV_INTERFACES</batman_adv_interfaces>"

	# Build a list of direct neighbors
	batman_adv_originators=$(/usr/sbin/batctl o -H | awk \
		'BEGIN { FS=" "; i=0 } # set the delimiter to " "
		{   sub("\\(", "", $0) # remove parentheses
			sub("\\)", "", $0)
			sub("\\[", "", $0)
			sub("\\]", "", $0)
			sub("\\*", "", $0)
			sub("  ", " ", $0)
			o=$1".*"$1 # build a regex to find lines that contains the $1 (=originator) twice
			if ($0 ~ o) # filter for this regex (will remove entries without direct neighbor)
			{
				printf "<originator_"i"><originator>"$1"</originator><link_quality>"$3"</link_quality><nexthop>"$4"</nexthop><last_seen>"$2"</last_seen><outgoing_interface>"$5"</outgoing_interface></originator_"i">"
				i++
			}
		}')

	echo -n "<batman_adv_originators>$batman_adv_originators</batman_adv_originators>"

	echo -n "<batman_adv_gateway_mode>$(/usr/sbin/batctl gw)</batman_adv_gateway_mode>"

	# Show local gateway as its own gateway for Monitoring
	ETHMESHDEV="$(uci -q get network.ethmesh.ifname)"
	[ -n "$ETHMESHDEV" ] && gwmac="$(cat "/sys/class/net/br-ethmesh/address" 2>/dev/null)"
	batman_adv_gateway_list="<gateway_0><selected>true</selected><gateway>$gwmac</gateway><link_quality>-1</link_quality><nexthop>$gwmac</nexthop><outgoing_interface>internal</outgoing_interface><gw_class>-</gw_class></gateway_0>"

	echo -n "<batman_adv_gateway_list>$batman_adv_gateway_list</batman_adv_gateway_list>"
else
	debug "$(date): No batman data .."
	exit 1
fi

exit 0
