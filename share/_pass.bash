#!/usr/bin/env bash

_pass_list() {
  local passwords
  IFS=$'\n' read -d '' -r -a passwords < <(find "$PASS_STORE/passwords/" -type f -not -path "*/.git/*" 2>/dev/null | awk -F "$PASS_STORE/passwords/" '{print $2}' | sed 's/\.age$//')
  COMPREPLY=($(compgen -W "${passwords[*]}" -- "${COMP_WORDS[COMP_CWORD]}"))
}

_pass_commands() {
  local commands="add new gen generate close cp copy clip custom help find git import ls list out output stdout rm remove rotate setup version"
  COMPREPLY=($(compgen -W "$commands" -- "${COMP_WORDS[COMP_CWORD]}"))
}

_pass_completion() {
  local cur prev
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"

  case "$cur" in
  add | new | gen | generate | close | cp | copy | clip | custom | help | find | git | import | ls | list | out | output | stdout | rm | remove | rotate | setup | version)
    _pass_commands
    return
    ;;
  esac

  case "$prev" in
  cp | copy | clip | out | output | stdout | rm | remove)
    _pass_list
    return
    ;;
  esac

  if [[ $COMP_CWORD -eq 1 ]]; then
    _pass_commands
  fi
}

complete -F _pass_completion pass
