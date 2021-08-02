#!/bin/bash

# Help message
if [[ "$1" = "--help" || "$1" = "-h" ]]; then
	cat <<EOF
Usage: $0 SNAPSHOT_UUID

Options:
  -h, --help	Prints this message
EOF
	exit
fi

if [[ ! -d ".vcs" ]]; then
	echo -e "Snapshot repository not initialized"
	exit 1
fi

SNAPSHOT_UUID="$1"

if [[ ! -e ".vcs/snapshots/$SNAPSHOT_UUID" ]]; then
	echo -e "The snapshot reference \"$SNAPSHOT_UUID\" doesn't exists"
	exit 1
fi

SNAPSHOT_FILE=".vcs/snapshots/$SNAPSHOT_UUID"
echo -e "Current Head UUID: $SNAPSHOT_UUID"

# Destructive operation!
find . -not -path . -not -path './.vcs' -not -path './.vcs/*' -delete
echo -e "Cleared current working directory"

# Restore the given reference
tail -n +2 "$SNAPSHOT_FILE" | sed -E 's/(.+?)\t(.+?)/mkdir -vp \"$(dirname \"\1\")\" \&\& cp -vp \".vcs\/files\/\2\" \"\1\"/;' | bash
echo -e "Snapshot restored"

echo -e "$SNAPSHOT_UUID" > .vcs/HEAD
echo -e "Updated current HEAD reference"
