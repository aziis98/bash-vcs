#!/bin/bash

if [[ ! -d ".vcs" ]]; then
	echo -e "Snapshot repository not initialized"
	exit 1
fi

echo -e ""

(cd .vcs/snapshots; find . -type f -printf "%T@|%Tc|%p\n" | sort -n | cut -d'|' -f 3 | sed -E 's/^..//;' | xargs stat -c ' > %n (%w)')

echo -e ""
echo -e " HEAD: $(cat ".vcs/HEAD")"
echo -e ""
