
# Shell VCS

> :warning: This is just a side-side-project so it's probably a good idea not to use this for anything serious :warning: 

A very small shell utility to version files. This is an extremely semplified version of git, the main utilities this is based on are `uuidgen` [:mag:](vcs_snapshot.sh#L8), `sha256sum` [:mag:](vcs_snapshot.sh#L13) and some other common unix cli utilities.

```
$ wc -l *.sh
  16 vcs_init.sh
  54 vcs_restore.sh
  14 vcs_show.sh
  35 vcs_snapshot.sh
 119 total
```

## Usage

- [`./vcs_init.sh`](./vcs_init.sh)
  
    Initialize a repository in this folder

- [`./vcs_show.sh`](./vcs_show.sh)
  
    List snapshots with relative UUIDs and creation dates in cronological order.

- [`./vcs_snapshot.sh`](./vcs_snapshot.sh)
  
    Create a snapshot of current working tree

- [`./vcs_restore.sh <uuid>`](./vcs_restore.sh)
  
    Restore a previous snapshot given its UUID. This will prompt for confirmation as this first clears the current working tree.

## ToDo / Ideas

- `vcs` 

    Add a main command with sub-commands: `vcs init`, `vcs snapshot`, ...

- `vcs init` should create a `.vcs/config` file

    - Give an option to gzip blobs inside `.vcs/files`, this should be disabled by default to keep things simpler and always accessible. Something like `vcs init --gzip`

- `vcs snapshot -m <message>`

    Let the user add a message and some notes when creating a snapshot. Or this can simply be solved with a `NOTES` files in the working tree and some magic inside `vcs show` (or with something like `vcs init --message-command 'cat ./NOTES'`).

### Names

- `myver`: "my version control system"

- `aver`: "aziis98 version control system"

- ...



