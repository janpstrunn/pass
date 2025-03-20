<img src="https://git.disroot.org/janpstrunn/images/raw/branch/main/pass.png" align="right" height="100"/>
<br>

# pass: A modern CLI password manager

`pass` is a simple password manager written in shell that tries to replace the [passwordstore](https://www.passwordstore.org/) keeping its core philosophies.

This project has some important differences compared to [passwordstore](https://www.passwordstore.org/). `pass` does not uses `gpg` like [passwordstore](https://www.passwordstore.org/), instead it uses `age` for a more modern and simple way to generate password stores.

It's a CLI tool that tries to make the process of managing passwords a breeze while keeping yourself secure with good security standards.

To understand the encryption logic behind the `age` backend, see [Encryption Logic](https://github.com/janpstrunn/pass/wiki/Encryption-Logic).

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
- Empower PIN passwords using `argon2` (see [Entropy Amplification](https://github.com/janpstrunn/pass/wiki/Encryption-Logic#entropy-amplification))
- Highly customizable and scriptable

## Requirements

- `age`
- `bash`, `zsh`, `fish` or any other shell
- `expect`
- `git`
- `pwgen`
- `srm`
- `xclip` or `wl-clipboard`
- `tree`

### Optional Requirements

- `argon2`
- `eza`
- `fd`
- `fzf`
- `zenity`

## Installation

```
curl -sSL https://github.com/janpstrunn/pass/raw/main/install.sh | bash
```

## Configuration

**Environment Variables:**

- `PASS_STORE`:
  - Password Directory.
  - Default to `"$HOME/.pass/"`
  - Setting `PASS_STORE` to any directory that is not present in `$HOME` will fail. This is a measure to preserve the user authority over their password store
- `PASSRC`:
  - Configuration file.
  - Default to `"$HOME/.passrc`

**Configuration File. Refer to [.passrc](https://github.com/janpstrunn/pass/blob/main/.passrc)**

## Usage

```
pass: A modern CLI password manager

Usage: $0 [options] <command> [arguments]

Options:
  -a [-s] <salt> [-i] <iteration>
                              Use Entropy Amplification
  -c                          Copy password to clipboard after password creation
  -d <zenity>                 Choose a dialog to get passwords
  -e                          Extra command run post clipboard cleareance
  -f                          Force. Bypass confirmation dialogs. May be destructive.
  -h, --help                  Display this help message and exit
  -i <iteration>              Define iterations for Entropy Amplification
  -n                          Enable notifications
  -p <pwgen-args>             Specify pwgen arguments
  -s <salt>                   Define salt for Entropy Amplification
  -z                          Don't keep private key cached

Commands:
  add, new, gen, generate [-a -f -c -p] <pass-name> <password-length>
                           Generate a new password
  close                    Remove cached private key
  cp, copy, clip [-a] <pass-name>
                           Copy password to clipboard
  custom <pass-cmd> <pin-cmd>
                           Specify a custom dialog to get master password and PIN
  find <pass-name>         Search passwords and display as a tree
  git <git-args>           Run any Git command in PASS_STORE
  import                   Import passwords from password store
  ls, list                 List all stored passwords in a tree format
  open                     Cache the private key
  out, output, stdout [-a] <pass-name>
                           Print password to stdout
  rm, remove [-f] <pass-name>
                           Remove a password entry
  rotate [-f]              Rotate all keys and update master password and PIN
  setup [-a]               Initialize keys, directories, and git
  version                  Display the current version number

Examples:
  pass new -c MyAccount 20
                       # Create password MyAccount as a 20 long character long password,
                       # and immediately copy it to clipboard
  pass clip MyAccount  # Copy MyAccount password to clipboard
  pass list            # List all available passwords
  pass git status      # Run git status in PASS_STORE
  pass rotate -f       # Rotate all keys, without confirmation
  pass -a setup        # Setup pass using Entropy Amplification
```

> [!IMPORTANT]
> First time running `pass`, requires to run the `setup` command: `./pass setup`

## Importing from passwordstore

For those who what to import passwords from passwordstore, you can simply run the following command:

```bash
./pass import
```

If `$PASSWORD_STORE_DIR` is not defined in your `.env` file, you can use the `-f` flag to set it to default

## Scripting

`pass` aims to be as much customizable as possible and scriptable to allow users to best adjust it to their workflows. Here are some examples how you can use `pass` in your scripts:

```bash
# This will take the password from pass and use it to unlock a gocryptfs vault
pass output dev/usb1 | gocryptfs /path/to/gocryptfs-vault /path/to/mount
# If you set a DIALOG in .passrc and you don't want to use it in a specific script. Use:
pass -d none output mypassword
# Guess you have JUST overwritten a password called google, and you want to revert it
git -C "$PASS_STORE" revert --no-edit $(pass git log --grep="google" --format="%H" -n 1)
# Perhaps you want to initialize your system and immediately put in your master password
# You can set this command to run when your system is loaded
pass -d zenity open
```

## Plans

### This repository

- [x] Add support for `git`
- [x] Create a .passrc
- [x] Re-encrypt all passwords with new age key
- [x] Import passwords from passwordstore
- [x] Complete overhaul on how private keys are managed and temporary stored
- [x] Create documentation
- [x] Create auto-completion for `bash` and `zsh`

### Extensions

- [x] Manage OTP passwords using [pass-otp](https://github.com/janpstrunn/pass-otp)
- [x] Store passwords in a tomb using [pass-tomb](https://github.com/janpstrunn/pass-tomb)
- [x] Manage Recovery Keys using ~`pass-recuva`~ [pass-otp](https://github.com/janpstrunn/pass-otp)
- [x] Easily use `pass` and its official extensions using [pass-rofi](https://github.com/janpstrunn/pass-rofi)

## Known Issues

- **Hoykeys**
  - When trying to attach `pass` to a hotkey, the keybinding manager (e.g. `sxhkd`) may not know `pass` exists unless you put `pass` in a upper `$PATH` directory like `/usr/local/bin/`
- **Password Prompt**
  - An inconvenient issue still to be addressed: Inserting the wrong password will mostly require `pass close` to be executed, and then try again.
- **Password Store**
  - Having both `pass` from this repository and the `passwordstore` installed may cause conflicts, because both receive the same name.
  - Solution 1: Keep `pass` out of `$PATH`
  - Solution 2: Uninstall `passwordstore`

## Notes

This script has been only tested in a Linux Machine.

## License

This repository is licensed under the MIT License, a very permissive license that allows you to use, modify, copy, distribute and more.
