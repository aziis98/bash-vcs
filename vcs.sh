#!/bin/bash

DIRNAME="$(dirname "$0")"

help() {
	cat <<EOF
Usage: $0 COMMAND [OPTIONS]...

Commands:

  init      Initialize a repository in current folder
  snapshot	Create a snapshot of current folder
  status	  List current head and all saved snapshots
  restore   Restore a previous snapshot given its uuid

EOF
}

if [[ $# -eq 0 ]]; then
	help
	exit 1
fi

COMMAND="$1"
shift

case "$COMMAND" in
	-h|--help)
		help
		exit 0
		;;
	init)
		$DIRNAME/vcs_init.sh $*
		exit 0
		;;
	# update)
	# 	$DIRNAME/vcs_updatecurrent.sh $*
	# 	echo -e "Updated .vcs/CURRENT"
	# 	exit 0
	# 	;;
	snapshot)
		$DIRNAME/vcs_snapshot.sh $*
		exit 0
		;;
	status)
		$DIRNAME/vcs_status.sh $*
		exit 0
		;;
	restore)
		if [[ "$1" = "--help" || "$1" = "-h" ]]; then
			cat <<EOF
Usage: $0 restore [-f] UUID

Options:
  -h, --help  Prints this message
  -f          Force a restore even if working tree has changes
EOF
			exit
		fi

		$DIRNAME/vcs_restore.sh $*
		exit 0
		;;
	*)
		echo -e "Unknown command \"$COMMAND\", must be one of: init, snapshot, status, restore."
		exit 1
		;;
esac

