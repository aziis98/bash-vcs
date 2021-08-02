#!/bin/bash

DIRNAME="$(dirname "$0")"

if [[ -d ".vcs" ]]; then
	echo -e "Repository already initialized";
	exit 1
fi

mkdir -p .vcs
mkdir -p .vcs/files
mkdir -p .vcs/snapshots

echo -e "Initialized the repository"

$DIRNAME/vcs_snapshot.sh
