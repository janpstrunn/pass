<img src="https://git.disroot.org/janpstrunn/images/raw/branch/main/pass.png" align="right" height="100"/>
<br>

<h1 align="left">Pass</h1>

`pass` is a simple password manager written in shell that tries to replace the [passwordstore](https://www.passwordstore.org/) keeping its core philosophies.

This project has some important differences. `pass` does not uses `gpg` like [passwordstore](https://www.passwordstore.org/), instead it uses `age` for a more modern and simple way to generate password stores.

It's a CLI tool that tries to make the process of managing passwords, one time passwords (2FA) and recovery keys a breeze while keeping yourself secure with good security standards. [Aware some current potential security issues](#potential-security-issues).

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
Usage: $0 [option] [command]
Available options:
-c, --clip                                  - Copy password to clipboard after generate or edit
-f, --force                                 - Lifts confirmation dialogs
-h, --help, usage                           - Displays this message and exists
-o                                          - Print password to stdout
Available commands:
clip [pass-name]                            - Copy password to clipboard
edit [pass-name]                            - Edit an existing password using nano
find [pass-name]                            - Find files and output as tree format
git [git-args]                              - Run any git coomand at PASS_STORE
import                                      - Import passwords from passwordstore
ls, list                                    - List all passwords in a tree format
new, generate -f -c [pass-name] [length]    - Generate a new password
reset -f                                    - Re-encrypts all passwords with new key and master password
rm, remove -f [pass-name]                   - Remove password from store
setup                                       - Setup keys, directories and git
version                                     - Displays the current version number
```

First time running `pass`, requires to run the `setup` command: `./pass setup`

## Planned

- [x] Add support for `git`
- [x] Create a .passrc
- [x] Re-encrypt all passwords with new age key
- [x] Import passwords from passwordstore

## Potential Security Issues

- A non-encrypted format of keys are stored at `/run/user/$(id -u)` when accessing their private keys
  - main.age is kept until session ends
  - pass.age is kept until an command ends
- Filenames and directories are kept non-encrypted, including git comments mentioning their names

## License

This repository is licensed under the MIT License, a very permissive license that allows you to use, modify, copy, distribute and more.
