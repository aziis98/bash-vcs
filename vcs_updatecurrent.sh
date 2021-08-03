#!/bin/bash

# Generate the database for the current working tree. 
# This is a list of sorted paths and hashes and is stored inside .vcs/CURRENT
find . -type f -not -path './.vcs/*' -exec sha256sum {} \; \
	| sed -E 's/(.+)?  (.+)?/\2\t\1/;' \
	| sort \
	| cat <(echo -e "Path\tHash") - \
	> .vcs/CURRENT
