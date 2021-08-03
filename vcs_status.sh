#!/bin/bash

if [[ ! -d ".vcs" ]]; then
	echo -e "Snapshot repository not initialized"
	exit 1
fi

DIRNAME="$(dirname "$0")"

# Update .vcs/CURRENT
$DIRNAME/vcs_updatecurrent.sh

echo -e ""
echo -e "   UUID                                 DATE"

(cd .vcs/snapshots; find . -type f -printf "%T@|%Tc|%p\n" \
	| sort -n \
	| cut -d'|' -f 3 \
	| sed -E 's/^..//;' \
	| xargs stat -c ' > %n %w')

echo -e ""
echo -e " HEAD: \"$(cat ".vcs/HEAD")\""
if cmp -s ".vcs/CURRENT" ".vcs/snapshots/$(cat ".vcs/HEAD")"; then
	echo -e " Up to date with HEAD"
else
	echo -e " Something has changed, you may want to take a snapshot"
fi
echo -e ""

