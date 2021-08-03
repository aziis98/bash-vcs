#!/bin/bash

if [[ ! -d ".vcs" ]]; then
	echo -e "Snapshot repository not initialized"
	exit 1
fi

DIRNAME="$(dirname "$0")"

# Update .vcs/CURRENT
$DIRNAME/vcs_updatecurrent.sh

# There is no need to create a snapshot if it matches HEAD.
if cmp -s ".vcs/CURRENT" ".vcs/snapshots/$(cat ".vcs/HEAD")"; then
	echo -e "Working tree already matches HEAD, no need to take a new snapshot."
	exit 0
fi

SNAPSHOT_UUID="$(uuidgen)"
SNAPSHOT_FILE=".vcs/snapshots/$SNAPSHOT_UUID"
echo -e "New Snapshot UUID: $SNAPSHOT_UUID"

cp ".vcs/CURRENT" "$SNAPSHOT_FILE"

# On first run copy all files inside .vcs/files and create .vcs/HEAD
#  otherwise compute file additions and save those inside .vcs/files
#  and also update the HEAD reference.
if [[ ! -e ".vcs/HEAD" ]]; then
	tail -n +2 ".vcs/snapshots/$SNAPSHOT_UUID" | sed -E 's/(.+?)\t(.+?)/cp -p \"\1\" \".vcs\/files\/\2\"/;' | bash
	echo -e "Initial Snapshot Saved"
else
	PREVIOUS_UUID="$(cat ".vcs/HEAD")"
	PREVIOUS_FILE=".vcs/snapshots/$PREVIOUS_UUID"
	echo -e "Previous Snapshot UUID: $PREVIOUS_UUID"

	comm -13 "$PREVIOUS_FILE" "$SNAPSHOT_FILE" | sed -E 's/(.+?)\t(.+?)/cp -p \"\1\" \".vcs\/files\/\2\"/;' | bash
	echo -e "Additions saved"
fi

echo -e "$SNAPSHOT_UUID" > .vcs/HEAD
echo -e "Updated HEAD reference"
