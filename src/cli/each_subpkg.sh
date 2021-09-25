# -*- coding: utf-8, tab-width: 2 -*-

function cli_each_subpkg () {
  case "$1" in
    ci )
      shift
      cli_each_subpkg npm install . || return $?
      cli_each_subpkg npm test "$@" || return $?
      return 0;;
  esac

  local MIN_DEPTH=0
  (( MIN_DEPTH += 1 )) # skip '.', as it would be pruned as hidden file
  (( MIN_DEPTH += 1 )) # exclude ./package.json
  local SUB_PKGS=(
    -mindepth "$MIN_DEPTH"
    -xdev
    -not -name '[A-Za-z0-9_]*' -prune ,
    -name node_modules -prune ,
    -type f -name package.json -print
    )
  readarray -t SUB_PKGS < <(find "${SUB_PKGS[@]}" | sort --version-sort)
  local ORIG_PWD="$PWD"
  local SUB= RV=
  for SUB in "${SUB_PKGS[@]}"; do
    SUB="${SUB%/*}"
    SUB="${SUB#.}"
    SUB="${SUB#/}"
    echo "=== $* @ $SUB ==="
    cd -- "$ORIG_PWD/$SUB" || return $?
    cli_multi "$@"; RV=$?
    if [ "$RV" == 0 ]; then
      echo
      cd -- "$ORIG_PWD" || return $?
    else
      sleep 0.25s
      # ^-- wait for late error messages from programs like npm@7
      echo
      echo "E: rv=$RV in $SUB for $*" >&2
      return "$RV"
    fi
  done
}

return 0
