<img src="https://git.disroot.org/janpstrunn/images/raw/branch/main/pass.png" align="right" height="100"/>
<br>

<h1 align="left">Pass</h1>

`pass` is a simple password manager written in shell that tries to replace the [passwordstore](https://www.passwordstore.org/) keeping its core philosophies.

This project has some important differences. `pass` does not uses `gpg` like [passwordstore](https://www.passwordstore.org/), instead it uses `age` for a more modern and simple way to generate password stores.

It's a CLI tool that tries to make the process of managing passwords, one time passwords (2FA) and recovery keys a breeze while keeping yourself secure with good security standards.

## Features

- List all files in a tree format using `tree` or `eza`
- Find files using `find` or `fd`
- Interactive password selection using `fzf`
- Import passwords from [passwordstore](https://www.passwordstore.org/)
- Output passwords to stdout
- Run any `git` command
- Generate strong passwords using `pwgen`
- Edit passwords
- Copy password to clipboard and clear clipboard on specified time
- Rotate `age` keys and re-encrypt all passwords

## Requirements

- `age`
- `git`
- `srm`
- `bash`, `zsh`, `fish` or any other shell
- `pwgen`
- `xclip` or `wl-clipboard`

### Optional Requirements

- `fzf`
- `eza`
- `fd`

## Installation

```
git clone https://github.com/janpstrunn/pass
cd pass
chmod 700 src/pass
mv src/pass "$HOME/.local/bin"
```

## Configuration

Environment Variables:

- `PASS_STORE`: Password Directory. Default to `"$HOME/.pass/"`
- `PASSRC`: Configuration file. Default to `"$HOME/.passrc`

Configuration File:

- `FORCE`: Always ignore confirmation dialogs
- `CLIPHIST_WIPE`: Clears the cliphist database
- `CLIPBOARD_CLEAR_TIME`: Time in seconds to clear the clipboard

## Usage

```
Pass: Password Manager

Usage: $0 [options] <command> [arguments]

Options:
  -c, --clip        Copy password to clipboard after generating or editing
  -f, --force       Bypass confirmation dialogs
  -h, --help        Display this help message and exit
  -o                Print password to stdout

Commands:
  clip <pass-name>         Copy password to clipboard
  edit <pass-name>         Edit an existing password using nano
  find <pass-name>         Search passwords and display as a tree
  git <git-args>           Run any Git command in PASS_STORE
  import                   Import passwords from password store
  ls, list                 List all stored passwords in a tree format
  new, generate [-f -c] <pass-name> <length>
                           Generate a new password
  reset [-f]               Re-encrypt all passwords with a new key and master password
  rm, remove [-f] <pass-name>
                           Remove a password entry
  setup                    Initialize keys, directories, and Git
  version                  Display the current version number

Examples:
  $0 new -c MyAccount 20
  $0 clip MyAccount
  $0 list
  $0 git status
  $0 reset -f
```

First time running `pass`, requires to run the `setup` command: `./pass setup`

## Plans

### This repository

- [x] Add support for `git`
- [x] Create a .passrc
- [x] Re-encrypt all passwords with new age key
- [x] Import passwords from passwordstore
- [x] Complete overhaul on how private keys are managed and temporary stored

### Helpers

- [x] Manage OTP passwords using [pass-otp](https://github.com/janpstrunn/pass-otp)
- [ ] Store passwords in a tomb using `pass-tomb`
- [ ] Manage Recovery Keys using `pass-recuva`
- [ ] Easily use `pass` and its helpers using `rofipass`

## License

This repository is licensed under the MIT License, a very permissive license that allows you to use, modify, copy, distribute and more.
