<img src="https://git.disroot.org/janpstrunn/images/raw/branch/main/pass.png" align="right" height="100"/>
<br>

# pass: A modern CLI password manager

`pass` is a simple password manager written in shell that tries to replace the [passwordstore](https://www.passwordstore.org/) keeping its core philosophies.

This project has some important differences compared to [passwordstore](https://www.passwordstore.org/). `pass` does not uses `gpg` like [passwordstore](https://www.passwordstore.org/), instead it uses `age` for a more modern and simple way to generate password stores.

It's a CLI tool that tries to make the process of managing passwords a breeze while keeping yourself secure with good security standards.

## Features

- List all files in a tree format using `tree` or `eza`
- Find files using `find` or `fd`
- Interactive password selection using `fzf`
- Import passwords from [passwordstore](https://www.passwordstore.org/)
- Output passwords to `stdout`
- Run any `git` command
- Generate strong passwords using `pwgen`
- Copy password to clipboard and clear clipboard on specified time
- Run post commands after clipboard clear
- Use `zenity` to insert passwords
- Specify a dialog tool to get master password and PIN
- Rotate `age` keys and re-encrypt all passwords
- Empower PIN passwords using `argon2` (Entropy Amplification)

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
- `expect`
- `argon2`
- `zenity`

## Installation

```
git clone https://github.com/janpstrunn/pass
cd pass
chmod 700 src/pass
mv src/pass "$HOME/.local/bin"
```

## Configuration

Environment Variables:

- `PASS_STORE`:
  - Password Directory.
  - Default to `"$HOME/.pass/"`
  - Setting `PASS_STORE` to any directory that is not present in `$HOME` will fail. This is a measure to preserve the user authority over their password store
- `PASSRC`:
  - Configuration file.
  - Default to `"$HOME/.passrc`

Configuration File. Refer to [.passrc](https://github.com/janpstrunn/pass/blob/main/.passrc)

- `FORCE`: Always ignore confirmation dialogs
- `CLIPHIST_WIPE`: Clears the `cliphist` database
- `CLIPBOARD_CLEAR_TIME`: Time in seconds to clear the clipboard
- `ENTROPY_AMPLIFICATION`: Always use Entropy Amplification (EA)
- `ENTROPY_SALT`: Set a salt to be used by EA
- `ENTROPY_ITERATION`: Set iterations used by EA
- `NOTIFY`: Always enable notifications
- `EXTRA_CLIPBOARD_CLEAR`: Command to be used after clipboard cleareance

## Usage

```
pass: A modern CLI password manager

Usage: $0 [options] <command> [arguments]

Options:
  -a [-s] <salt> [-i] <iteration>
  -c                          Copy password to clipboard after password creation
  -d [zenity]                 Choose a dialog to get passwords
  -e                          Extra command run post clipboard cleareance
  -f                          Force. Bypass confirmation dialogs. May be destructive.
  -h, --help                  Display this help message and exit
  -n                          Enable notifications
  -p [pwgen-args]             Specify pwgen arguments
                              Use Entropy Amplification
  -z                          Don't keep private key cached

Commands:
  add, new, gen, generate [-a -f -c -p] <pass-name> <password-length>
                           Generate a new password
  close                    Remove cached private key
  cp, copy, clip [-a] <pass-name>
                           Copy password to clipboard
  custom [pass-cmd] [pin-cmd]
                           Specify a custom dialog to get master password and PIN
  find <pass-name>         Search passwords and display as a tree
  git <git-args>           Run any Git command in PASS_STORE
  import                   Import passwords from password store
  ls, list                 List all stored passwords in a tree format
  out, output, stdout [-a] <pass-name>
                           Print password to stdout
  rm, remove [-f] <pass-name>
                           Remove a password entry
  rotate [-f]              Rotate all keys and update master password and PIN
  setup                    Initialize keys, directories, and git
  version                  Display the current version number

Examples:
  $0 new -c MyAccount 20
                     # Create password MyAccount as a 20 long character long password,
                     # and immediately copy it to clipboard
  $0 clip MyAccount  # Copy MyAccount password to clipboard
  $0 list            # List all available passwords
  $0 git status      # Run git status in PASS_STORE
  $0 rotate -f       # Rotate all keys, without confirmation
  #0 -a setup        # Setup pass using Entropy Amplification
```

First time running `pass`, requires to run the `setup` command: `./pass setup`

## Plans

### This repository

- [x] Add support for `git`
- [x] Create a .passrc
- [x] Re-encrypt all passwords with new age key
- [x] Import passwords from passwordstore
- [x] Complete overhaul on how private keys are managed and temporary stored
- [ ] Create documentation
- [ ] Create auto-completion for `bash` and `zsh`

### Helpers

- [x] Manage OTP passwords using [pass-otp](https://github.com/janpstrunn/pass-otp)
- [ ] Store passwords in a tomb using `pass-tomb`
- [ ] Manage Recovery Keys using `pass-recuva`
- [ ] Easily use `pass` and its helpers using `rofipass`

## License

This repository is licensed under the MIT License, a very permissive license that allows you to use, modify, copy, distribute and more.
