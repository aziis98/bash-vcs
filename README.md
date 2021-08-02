
# Personal Shell Version Control System

A very simple shell utility to version files based on `uuidgen` and `sha256sum`.

## Usage

- [`vcs_init`](./vcs_init.sh)
	
	Initialize a repository in this folder

- [`vcs_show`](./vcs_show.sh)
	
	List snapshots with relative UUIDs in cronological order.

- [`vcs_snapshot`](./vcs_snapshot.sh)
	
	Create a snapshot of current working tree

- [`vcs_restore <uuid>`](./vcs_restore.sh)
	
	Restore a previous snapshot given its UUID.





