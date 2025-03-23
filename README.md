<img src="https://git.disroot.org/janpstrunn/images/raw/branch/main/pass.png" align="right" height="100"/>
<br>

# pass: A Modern CLI Password Manager

`pass` is an elegant and efficient password manager crafted in shell, designed to replace the [passwordstore](https://www.passwordstore.org/) while maintaining its core principles. Unlike `passwordstore`, `pass` leverages `age` for a more contemporary and streamlined approach to password management, ensuring robust security standards.

To understand the encryption logic behind the `age` backend, see [Encryption Logic](https://github.com/janpstrunn/pass/wiki/Encryption-Logic).

## Features

- **Tree View**: List all files in a tree format using `tree` or `eza`.
- **File Search**: Find files effortlessly using `find` or `fd`.
- **Interactive Selection**: Use `fzf` for interactive password selection.
- **Seamless Import**: Import passwords from [passwordstore](https://www.passwordstore.org/).
- **Output Management**: Output passwords directly to `stdout`.
- **Git Integration**: Run any `git` command within your password store.
- **Strong Passwords**: Generate strong passwords using `pwgen`.
- **Clipboard Management**: Copy passwords to the clipboard and clear them after a specified time.
- **Post-Clipboard Commands**: Execute commands after clipboard clearance.
- **Graphical Input**: Use `zenity` for inserting passwords.
- **Dialog Customization**: Specify a dialog tool to get the master password and PIN.
- **Key Rotation**: Rotate `age` keys and re-encrypt all passwords.
- **Enhanced Security**: Empower PIN passwords using `argon2` (see [Entropy Amplification](https://github.com/janpstrunn/pass/wiki/Encryption-Logic#entropy-amplification))
- **Highly Customizable**: Tailor the tool to your specific needs and workflows.

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

**Configuration File:**

Refer to `.passrc` for detailed configuration options.

## Usage

```
  ---------------------------------------------------
  -----------------------pass------------------------
  ---------------------------------------------------
  -----------A modern CLI password manager-----------
  ---------------------------------------------------

Usage: pass [options] <command> [arguments]

  -a [-s] <salt> [-i] <iteration>
                              Use Entropy Amplification
  -c                          Copy password to clipboard after password creation
  -d <zenity>                 Choose a dialog to get passwords
  -e                          Extra command run post clipboard cleareance
  -f                          Force. Bypass confirmation dialogs. May be destructive.
  -h, --help                  Display this help message and exit
  -l <parallels>              Define paralellism for Entropy Amplification
  -i <iteration>              Define iterations for Entropy Amplification
  -n                          Enable notifications
  -p <pin>                    Antecipate PIN
  -o <pwgen-args>             Specify pwgen arguments
  -s <salt>                   Define salt for Entropy Amplification
  -z                          Don't keep private key cached

Commands:
  add, new, gen, generate [-a -f -c -p] <pass-name> <password-length>
                           Generate a new password
  close                    Remove cached private key
  cp, copy, clip [-a] <pass-name>
                           Copy password to clipboard
  custom, custom-cmd <pass-cmd> <pin-cmd>
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
  setup                    Initialize keys, directories, and git
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

For those transitioning from `passwordstore`, simply run:

```bash
./pass import
```

If `$PASSWORD_STORE_DIR` is not defined in your `.env` file, use the `-f` flag to set it to the default directory: `$HOME/.password-store/`.

## Scripting

`pass` is designed to be highly customizable and scriptable, allowing users to integrate it seamlessly into their workflows. Here are some examples:

```bash
# Unlock a gocryptfs vault using a password from pass
pass output gocryptfs/myvault | gocryptfs /mnt/gocryptfs-vault /home/user/vault/gocryptfs-vault
# Bypass the DIALOG in .passrc for a specific script
pass -d none output gocryptfs/myvault
# Revert an overwritten password called google
pass git revert --no-edit $(pass git log --grep="google" --format="%H" -n 1)
# Initialize your system and input your master password
pass -d zenity open
# Avoid PIN requests entirely
mygooglepass=$(pass -p StrongestPinEver stdout email/google)
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

- **Hotkeys:** Keybinding managers (e.g., `sxhkd`) may not recognize `pass` unless it is placed in a higher `$PATH` directory like `/usr/local/bin/`.
- **Password Store Conflicts:** Having both `pass` and `passwordstore` installed may cause conflicts due to identical names.
  - **Solution 1:** Keep `pass` out of `$PATH`.
  - **Solution 2:** Uninstall `passwordstore`.

## Notes

This script has been tested exclusively on a Linux machine.

## License

This repository is licensed under the MIT License, allowing for extensive use, modification, copying, and distribution.
