# -*- coding: utf-8, tab-width: 2 -*-

function cli_reaudit () {
  npm install --package-lock --package-lock-only . || return $?$(
    echo "E: Failed to renew package-lock.json" >&2)
  local TMP_LOG="tmp.$$.reaudit.log"
  local DEST_LOG='audit.log'
  npm audit "$@" |& tee -- "$TMP_LOG"
  local AUDIT_RV="${PIPESTATUS[0]}"
  [ "$AUDIT_RV" == 0 ] || DEST_LOG="${DEST_LOG%.*}.err"
  mv --no-target-directory -- "$TMP_LOG" "$DEST_LOG" || return $?$(
    echo "E: Failed to rename audit log" >&2)
  return "$AUDIT_RV"
}

return 0
