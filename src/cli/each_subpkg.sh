# -*- coding: utf-8, tab-width: 2 -*-

function cli_each_subpkg () {
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
  local SUB=
  for SUB in "${SUB_PKGS[@]}"; do
    SUB="${SUB%/*}"
    SUB="${SUB#.}"
    SUB="${SUB#/}"
    echo "=== $* @ $SUB ==="
    cd -- "$ORIG_PWD/$SUB" || return $?
    "$@" || return $?
    cd -- "$ORIG_PWD" || return $?
    echo
  done
}

return 0
