#!/bin/bash

if [[ ! -d ".vcs" ]]; then
	echo -e "Snapshot repository not initialized"
	exit 1
fi

SNAPSHOT_UUID="$(uuidgen)"
SNAPSHOT_FILE=".vcs/snapshots/$SNAPSHOT_UUID"
echo -e "New Snapshot UUID: $SNAPSHOT_UUID"

# Generate a snapshot of current files. This is a list of sorted paths and hashes.
find . -type f -not -path './.vcs/*' -exec sha256sum {} \; \
	| sed -E 's/(.+)?  (.+)?/\2\t\1/;' \
	| sort \
	| cat <(echo -e "Path\tHash") - \
	> $SNAPSHOT_FILE

# On first run copy all files inside .vcs/files and create .vcs/HEAD
#  otherwise compute file additions and save those inside .vcs/files
#  and also update the HEAD reference.
if [[ ! -e ".vcs/HEAD" ]]; then
	tail -n +2 ".vcs/snapshots/$SNAPSHOT_UUID" | sed -E 's/(.+?)\t(.+?)/cp -p \"\1\" \".vcs\/files\/\2\"/;' | bash
	echo -e "Initial Snapshot Saved"
else
	PREVIOUS_UUID="$(cat ".vcs/HEAD")"
	PREVIOUS_FILE=".vcs/snapshots/$PREVIOUS_UUID"
	echo -e "Current Head UUID: $PREVIOUS_UUID"

	echo -e "Saving additions:"
	comm -13 "$PREVIOUS_FILE" "$SNAPSHOT_FILE" | sed -E 's/(.+?)\t(.+?)/cp -p \"\1\" \".vcs\/files\/\2\"/;' | bash
fi

echo -e "$SNAPSHOT_UUID" > .vcs/HEAD
echo -e "Updated current HEAD reference"
