
# Shell VCS

> :warning: This is just a side-side-project so it's probably a good idea not to use this for anything serious :warning: 

A very small shell utility to version files. This is an extremely semplified version of git, the main utilities this is based on are `uuidgen` [:mag:](./vcs_snapshot.sh#L8), `sha256sum` [:mag:](./vcs_snapshot.sh#L13) and some other common unix cli utilities.

```
$ wc -l *.sh
  16 vcs_init.sh
  65 vcs_restore.sh
  69 vcs.sh
  41 vcs_snapshot.sh
  30 vcs_status.sh
   9 vcs_updatecurrent.sh
 230 total
```

## Usage

- [`./vcs.sh [-h|--help] <command> ...`](./vcs.sh)

    Main command that shows help messages and dispatches sub-commands.

- [`./vcs.sh init`](./vcs_init.sh)
  
    Initialize a repository in this folder.

- [`./vcs.sh status`](./vcs_status.sh)
  
    List snapshots with relative UUIDs and creation dates in cronological order. Also shows current status of the working tree with respect to the HEAD snapshot.

- [`./vcs.sh snapshot`](./vcs_snapshot.sh)
  
    If there are some changes with respect to HEAD takes a snapshot of current working tree.

- [`./vcs.sh restore [-f] <uuid>`](./vcs_restore.sh)
  
    Restore a previous snapshot given its UUID. This will prompt for confirmation as this first clears the current working tree.

## Directory Structure

### [./example](./example)

[TODO: Add diagrams for all the various versions as an example]

#### ...

#### Version 4

```
.
├── .vcs
│   ├── files
│   │   ├── 003178bac0562b55d6fd0b9914539e1b0eca9e97481ce9ba78b2d092c4c74f26
│   │   ├── 2aff1a29fada220782ba958feb400fe17b589e87be471d30edf404951cad9f7c
│   │   ├── 881c1cc77109dd5c63143abeba0ed249e875d331a13f8c639504d055839d76d7
│   │   ├── 8bf9628c223fb282e5578144e37bfec6dce749e6f424ef4475d0e00af36dfa2c
│   │   └── aa649449813f85b1354ad17809f50b23e52e41a1da3ddd02f2ad04161a5c2e01
│   ├── snapshots
│   │   ├── 28b2d2b9-efe2-43a5-9802-f26b9605917a
│   │   ├── 7be29454-0716-44a8-ab82-4ef85fb71e67
│   │   ├── d10d0ced-479b-4fb6-89cb-99f07def893f
│   │   └── debeb2e5-a94e-4088-b4f6-5ba9bcfd687e
│   ├── CURRENT
│   └── HEAD
├── a.txt
├── b.txt
└── c.txt
```

## ToDo / Ideas

- `vcs init` should create a `.vcs/config` file

    - Give an option to gzip blobs inside `.vcs/files`, this should be disabled by default to keep things simpler and always accessible. Something like `vcs init --gzip`

- `vcs snapshot -m <message>`

    Let the user add a message and some notes when creating a snapshot. Or this can simply be solved with a `NOTES` files in the working tree and some magic inside `vcs status` (or with something like `vcs init --message-command 'cat ./NOTES'`).

### Names

- `myver`: "my version control system"

- `aver`: "aziis98 version control system"

- ...



