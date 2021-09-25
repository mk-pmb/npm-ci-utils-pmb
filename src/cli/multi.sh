# -*- coding: utf-8, tab-width: 2 -*-

function cli_multi () {
  local SEP=','
  case "$1" in
    [A-Za-z0-9_/.]* ) ;;
    * ) SEP="$1"; shift;;
  esac
  local TODO=( "$@" "$SEP" )
  local TASK=()
  local ARG=
  while [ "${#TODO[@]}" -ge 1 ]; do
    ARG="${TODO[0]}"; TODO=( "${TODO[@]:1}" )
    if [ "$ARG" == "$SEP" ]; then
      [ "${#TASK[@]}" == 0 ] && continue
      case "${TASK[0]}" in
        :* ) TASK[0]="cli_${TASK[0]#:}";;
      esac
      "${TASK[@]}" || return $?
      TASK=()
    else
      TASK+=( "$ARG" )
    fi
  done
}

return 0
