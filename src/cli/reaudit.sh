# -*- coding: utf-8, tab-width: 2 -*-

function cli_reaudit () {
  npm install --package-lock --package-lock-only . || return $?$(
    echo "E: Failed to renew package-lock.json" >&2)
  local TMP_LOG="tmp.$$.reaudit.log"
  npm audit "$@" |& tee -- "$TMP_LOG"
  local AUDIT_RV="${PIPESTATUS[0]}"

  local LOG_BFN='audit'
  local LOG_FEXT='log'
  rm -- "$LOG_BFN".{err,log} 2>/dev/null || true
  [ "$AUDIT_RV" == 0 ] || LOG_FEXT='err'
  mv --no-target-directory -- "$TMP_LOG" "$LOG_BFN.$LOG_FEXT" || return $?$(
    echo "E: Failed to rename audit log" >&2)
  return "$AUDIT_RV"
}

return 0
