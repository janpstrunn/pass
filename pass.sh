#!/usr/bin/env bash

# Environment Variables are preferable
PASS_STORE=${PASS_STORE:-"$HOME/.pass/"}
OTP_STORE=${OTP_STORE:-"$PASS_STORE/otp/"}
PASSWORD_STORE=${PASSWORD_STORE:-"$PASS_STORE/passwords/"}

KEY_STORE=${KEY_STORE:-"$PASS_STORE/keys/"}
MAIN_KEY_STORE=${MAIN_KEY_STORE:-"$PASS_STORE/keys/main.asc"}

function help() {
  cat <<EOF
Password Manager
Usage: $0 [option]
Available options:
help                            - Displays this message and exits
EOF
}

function error_check() {
  error=$?
  [[ "$error" -ne 0 ]] && {
    echo "An error occurred!"
    exit 1
  }
}

function init() {
  #TODO: re-encrypt all passwords with new age key
  echo "WIP"
}

function setup() {
  echo "Setting up"
  echo "1. Creating a dedicated directory for pass and its subdirectories"
  mkdir -p "$PASS_STORE" "$KEY_STORE" "$OTP_STORE" "$PASSWORD_STORE"
  error_check
  echo "2. Creating an exclusive GPG key to use pass"
  gpg --full-generate-key
  error_check
  echo "3. Creating your main age key"
  read -p "Please enter your GPG email you just created: " email
  age-keygen | gpg --encrypt -a --recipient "$email" >"$KEY_STORE"/main.asc
  error_check
  echo "Setup Complete"
  #TODO: make pass usage introduction
}

function fallback_main_key() {
  if [ -z "$key" ]; then
    key=$MAIN_KEY_STORE
  else
    key="$KEY_STORE/$key"
  fi
}

function stabilize-path() {
  local path
  path=$(dirname "$1")
  mkdir -p "$path"
  error_check
}

function get_age_key() {
  local key
  key=$1
  gpg --decrypt "$PASS_STORE"/"$key"
  error_check
}

function generate_password() {
  fallback_main_key
  key=$(get_age_key "$key")
  stabilize-path "$name"
  pwgen "$lengh" -Bsncy1n | age --encrypt --recipient="$key" --output="$PASSWORD_STORE"/"$name".age
  error_check
  git -C "$PASS_STORE" add . && git -C "$PASS_STORE" commit . -m "Add generated password for $name"
}

function edit_password() {
  EDITOR=${EDITOR:-vim}
  fallback_main_key
  key=$(get_age_key "$key")
  new_password=$(age --decrypt --identity="$key" "$PASSWORD_STORE"/"$name".age | $EDITOR)
  age --encrypt --recipient="$key" "$new_password" >"$PASSWORD_STORE"/"$name".age
  stabilize-path "$name"
  error_check
  git -C "$PASS_STORE" add . && git -C "$PASS_STORE" commit . -m "Add generated password for $name"
}

function clear_clipboard() {
  if [ "$clipmethod" = "x11" ]; then
    echo "" | xclip -sel clip
  elif [ "$clipmethod" = "wayland" ]; then
    echo "" | wl-copy
  fi
  # Extra command to be executed after clipboard is cleared
  # Example: PASS_CLEAR="cliphist wipe"
  if [ -n "$PASS_CLEAR" ]; then
    eval "$(PASS_CLEAR)"
  fi
}

function copy_password() {
  clipmethod="$XDG_SESSION_TYPE"
  fallback_main_key
  key=$(get_age_key "$key")
  if [ "$clipmethod" = "x11" ]; then
    age --decrypt --identity="$key" "$PASSWORD_STORE"/"$name".age | xclip -sel clip
  elif [ "$clipmethod" = "wayland" ]; then
    age --decrypt --identity="$key" "$PASSWORD_STORE"/"$name".age | wl-copy
  fi
  error_check
  echo "Clearing the password from clipboard in 5 seconds..."
  sleep 5s
  clear_clipboard
}

while [[ "$1" != "" ]]; do
  case "$1" in
  -h | --help)
    help
    exit 0
    ;;
  -s | --setup)
    setup
    exit 0
    ;;
  -i | --init)
    init
    exit 0
    ;;
  -n | --new | --generate)
    shift
    name=$1
    lengh=$2
    key=$3
    generate_password
    exit 0
    ;;
  -e | --edit)
    shift
    name=$1
    key=$2
    edit_password
    exit 0
    ;;
  -c | --copy)
    shift
    name=$1
    key=$2
    copy_password
    exit 0
    ;;
  esac
done
