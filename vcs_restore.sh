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

if [[ -z "$SNAPSHOT_UUID" ]]; then
	cat <<EOF 
Missing UUID of snapshot to restore

  Usage: $0 <uuid>

EOF
	exit 1
fi

if [[ ! -e ".vcs/snapshots/$SNAPSHOT_UUID" ]]; then
	echo -e "Snapshot \"$SNAPSHOT_UUID\" doesn't exists"
	exit 1
fi

SNAPSHOT_FILE=".vcs/snapshots/$SNAPSHOT_UUID"
echo -e "Current Head UUID: $SNAPSHOT_UUID"

echo -e "This will clear the current working tree and restore the previous snapshot"
read -p "Are you sure to continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# Destructive operation!
	find . -not -path . -not -path './.vcs' -not -path './.vcs/*' -delete
	echo -e "Cleared current working directory"

	# Restore the given reference
	tail -n +2 "$SNAPSHOT_FILE" | sed -E 's/(.+?)\t(.+?)/mkdir -p \"$(dirname \"\1\")\" \&\& cp -p \".vcs\/files\/\2\" \"\1\"/;' | bash
	echo -e "Snapshot restored"

	echo -e "$SNAPSHOT_UUID" > .vcs/HEAD
	echo -e "Updated current HEAD reference"
else
	echo -e "Operation aborted, kept current working tree"
fi
