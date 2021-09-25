#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-

function cli_main () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local REPO_DIR="$(readlink -m -- "$BASH_SOURCE"/../..)"
  local LIB=
  for LIB in "$REPO_DIR"/src/cli/*.sh; do
    source -- "$LIB" --lib || return $?
  done
  unset LIB
  cli_multi "$@"; return $?
}

cli_main "$@"; exit $?
