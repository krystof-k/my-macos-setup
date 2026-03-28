#!/usr/bin/env bash

block_present() {
  local file="$1"
  local marker_id="$2"

  grep -q "# BEGIN my-macos-setup:${marker_id}" "$file" 2>/dev/null
}

append_block_if_missing() {
  local file="$1"
  local marker_id="$2"
  local content="$3"

  if block_present "$file" "$marker_id"; then
    return 0
  fi

  {
    echo "# BEGIN my-macos-setup:${marker_id}"
    echo "$content"
    echo "# END my-macos-setup:${marker_id}"
    echo ""
  } >> "$file"
}
