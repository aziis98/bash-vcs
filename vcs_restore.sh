#!/bin/bash

if [[ ! -d ".vcs" ]]; then
	echo -e "No snapshot repository in this folder"
	exit 1
fi

FORCE_RESTORE=0
if [[ "$1" = "-f" ]]; then
	shift
	FORCE_RESTORE=1
fi

RESTORE_UUID="$1"
if [[ -z "$RESTORE_UUID" ]]; then
	cat <<EOF 
Missing UUID of snapshot to restore

  Usage: $0 <uuid>

EOF
	exit 1
fi

if [[ "$RESTORE_UUID" = "$(cat ".vcs/HEAD")" ]]; then
	echo -e "The given UUID is already the HEAD, no need to restore it."
	exit 0
fi

DIRNAME="$(dirname "$0")"

# Update .vcs/CURRENT
$DIRNAME/vcs_updatecurrent.sh

if [[ "$FORCE_RESTORE" = "0" ]]; then
	# Check CURRENT working tree matches the HEAD snapshot.
	if ! cmp -s ".vcs/CURRENT" ".vcs/snapshots/$(cat ".vcs/HEAD")"; then
		echo -e "Something has changed, you may want to take a snapshot first. Otherwise pass -f to force the restore."
		exit 0
	fi
fi

if [[ ! -e ".vcs/snapshots/$RESTORE_UUID" ]]; then
	echo -e "Snapshot \"$RESTORE_UUID\" doesn't exists"
	exit 1
fi

SNAPSHOT_FILE=".vcs/snapshots/$RESTORE_UUID"

echo -e "This will clear the current working tree and restore the previous snapshot"
read -p "Are you sure to continue? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# Destructive operation!
	find . -not -path . -not -path './.vcs' -not -path './.vcs/*' -delete

	# Restore the given reference
	while IFS=$'\t' read -r path hashcode ; do
		mkdir -p "$(dirname "$path")"
		cp -p ".vcs/files/$hashcode" "$path"
	done < <(tail -n +2 "$SNAPSHOT_FILE")

	echo -e "Snapshot restored"

	echo -e "$RESTORE_UUID" > .vcs/HEAD
	echo -e "Updated HEAD reference"
else
	echo -e "\n"
	echo -e "Operation aborted, kept working tree unchanged"
fi
