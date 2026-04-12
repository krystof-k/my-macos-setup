#!/usr/bin/env bash

# try_cmd <output_relative_path> <command...>
try_cmd() {
  local rel_path="$1"; shift
  local out="$PHASE_DIR/$rel_path"
  mkdir -p "$(dirname "$out")"
  message "\`$*\`" 'substep'
  if "$@" > "$out" 2>/dev/null; then
    :
  else
    echo "FAILED: $rel_path ($*)" >> "$FAIL_LOG"
    message "Failed: \`${rel_path}\`" 'substep' 'prompt'
    rm -f "$out"
  fi
  return 0
}

# try_copy [--sudo] <source> <dest_relative>
try_copy() {
  local sudo_prefix=()
  [[ "${1:-}" == "--sudo" ]] && sudo_prefix=(sudo) && shift
  local src="$1"
  local rel_path="$2"
  local dest="$PHASE_DIR/$rel_path"

  if [[ ! -e "$src" ]]; then
    message "Skipped (not found): \`${src}\`" 'substep'
    return 0
  fi

  mkdir -p "$(dirname "$dest")"
  message "\`${src}\`" 'substep'

  if [[ -d "$src" ]]; then
    if "${sudo_prefix[@]}" rsync -rlt --no-specials --inplace "$src/" "$dest/" >/dev/null 2>&1; then
      :
    else
      echo "FAILED: copy $src -> $rel_path" >> "$FAIL_LOG"
      message "Failed: \`${rel_path}\`" 'substep' 'prompt'
    fi
  else
    if "${sudo_prefix[@]}" cp "$src" "$dest" 2>/dev/null; then
      :
    else
      echo "FAILED: copy $src -> $rel_path" >> "$FAIL_LOG"
      message "Failed: \`${rel_path}\`" 'substep' 'prompt'
    fi
  fi
  return 0
}
