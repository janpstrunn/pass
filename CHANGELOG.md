# Changelog

## [1.1.1]

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
