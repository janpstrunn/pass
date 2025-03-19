# Changelog

## [2.2.1-1] 2025-03-19

### Changed

- Only run `output_password` if the filename is `pass`
- Make `clip_method` a global variable

## [2.2.1] 2025-03-19

### Added

- Option to force import passwords from passwordstore, by force setting PASSWORD_STORE_DIR as `$HOME/.password-store/`

### Fixed

- Proper variable setting to some scriptable functions

## [2.2.0] 2025-03-19

### Added

- Option to not keep a private key cached
- Add option to run commands after clipboard clear
- Add option to specify a dialog tool to get master password and PIN

### Changed

- Lift hardcode PASS_STORE directory within functions. This allows reusing the function with a different PASS_STORE subdirectory, for example a OTP dedicated subdirectory.

### Removed

- All option long formats are removed

## [2.1.1] 2025-03-18

### Added

- Long form options for Entropy Amplification (--amplify) and Notifications (--notify)
- Installation check for `argon2`, `zenity` and `expect` when about to be used

### Fixed

## [2.1.0] 2025-03-18

### Added

- Use `zenity` to get master password and PIN passwords
- Use `notify-send` to notify on clipboard copy

### Fixed

- Key rotation not working properly

## [2.0.0] 2025-03-18

### Added

- **Entropy Amplification:** Use powerful hashing (`argon2`) to increase the PIN's entropy required to decrypt pass.age.

### Changed

- `age` keys are now securely stored and manage, without ever leaving an copy in plain-text differently from versions 1.x.x

### Removed

- Editing passwords with an visual editor is deprecated.

## [1.1.1] 2025-03-17

### Added

- Change password permission when importing, and commit changes

### Fixed

- Leftovers not being wiped

### Changed

- Improve overall help menu

## [1.1.0] 2025-03-17

### Added

- Passwords are only accessed by the user (permission 600)

### Fixed

- `pass.pubkey` leftover, when setup fails
- Import note repeating across password encryption
- `fzf` not returning the correct password names

## [1.0.0] 2025-03-17

### Added

- List all files in a tree format using `tree` or `eza`
- Find files using `find` or `fd`
- Interactive password selection using `fzf`
- Import passwords from passwordstore
- Output passwords to `stdout`
- Run any `git` command
- Generate strong passwords using `pwgen`
- Edit passwords
- Copy password to clipboard and clear clipboard on specified time
- Rotate `age` keys and re-encrypt all passwords
