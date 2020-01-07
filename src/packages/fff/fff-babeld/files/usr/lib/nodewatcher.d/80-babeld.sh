#!/bin/sh

#BABELS=$(echo dump | nc ::1 33123 | awk '/^add neighbour/ {print "<neighbour>"$5"<outgoing_interface>"$7"</outgoing_interface></neighbour>"}')
BABELS="$(echo dump | nc ::1 33123 | grep '^add neighbour' |
	awk -v RS='\n' \
		'{r = gensub(/.*add neighbour.*address ([0-9a-fA-F:]*) +if +([^ ]+).* cost +([0-9.]+).*/, "<neighbour><ip>\\1</ip><outgoing_interface>\\2</outgoing_interface><link_cost>\\3</link_cost></neighbour>", "g"); print r;}')"

echo -n "<babel_neighbours>$BABELS</babel_neighbours>"

exit 0
