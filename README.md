
# Shell VCS

A very small shell utility to version files. This is an extremely semplified version of git and is based mostly on `uuidgen` and `sha256sum` and some other common unix cli utilities.

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

## Notes / ToDo / Ideas

- `vcs` 

    Add a main command with sub-commands: `vcs init`, `vcs snapshot`, ...

- `vcs init` should create a `.vcs/config` file

    - Give an option to gzip blobs inside `.vcs/files`, this should be disabled by default to keep things simpler and always accessible.

### Names

- `myver`: "my version control system"

- `aver`: "aziis98 version control system"

- ...



