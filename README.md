# protonrun

Script to run commands inside proton prefixes of Steam games.

Protonrun will run a command in a WINE environment of the Proton prefix used by
a selected Steam app.

The following variables are set: `WINEPREFIX`, `WINESERVER`, `WINELOADER`,
`WINEDLLPATH`, `PATH` (the `bin` directory of Proton distribution is
prepended), `PROTON` (the base directory of Proton distribution used by the
Steam app).

## Usage

To run `winecfg` for the prefix of `Vampire: The Masquerade - Bloodlines`:

```
$ protonrun winecfg
1) "Blasphemous"
2) "FINAL FANTASY VI"
3) "Vampire: The Masquerade - Bloodlines"
#? 3
```

To select the app without the selection prompt, set `PROTONRUN_APP_ID`:

```
$ env PROTONRUN_APP_ID=2600 protonrun winecfg
```

To see the IDs of installed apps, use:

```
$ protonrun --list
```

For more detailed usage:

```
$ protonrun --help
```

## Requirements

- Running: `bash>=5.0` (not tested on earlier verions)
- Testing: `bats-core>=1.1`, `expect>=5.45`

## Installation

Not required; just run the `protonrun` script directly, or put on `PATH` for
convenience.
