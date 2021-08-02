
# Personal Shell Version Control System

A very small shell utility to version files, this is base mostly on `uuidgen` and `sha256sum` and some other common unix cli utilities.

```
$ wc -l *.sh
  16 vcs_init.sh
  54 vcs_restore.sh
  14 vcs_show.sh
  35 vcs_snapshot.sh
 119 total
```

## Usage

- [`vcs_init`](./vcs_init.sh)
	
	Initialize a repository in this folder

- [`vcs_show`](./vcs_show.sh)
	
	List snapshots with relative UUIDs in cronological order.

- [`vcs_snapshot`](./vcs_snapshot.sh)
	
	Create a snapshot of current working tree

- [`vcs_restore <uuid>`](./vcs_restore.sh)
	
	Restore a previous snapshot given its UUID.

## Notes / Ideas

- `vcs`: `vcs init`, `vcs snapshot`, ...

### Names

- `myver`: "my vcs"

- `aver`: "aziis98 vcs"

- ...



