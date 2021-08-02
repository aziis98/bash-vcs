#!/bin/bash

if [[ ! -d ".vcs" ]]; then
	echo -e "Snapshot repository not initialized"
	exit 1
fi

(cd .vcs/snapshots; find . -type f -printf "%T@|%Tc|%p\n" | sort -n | cut -d'|' -f 3 | sed -E 's/^..//;' | xargs stat -c 'ref: %n  %w')

echo -e "Head: $(cat ".vcs/HEAD")"
