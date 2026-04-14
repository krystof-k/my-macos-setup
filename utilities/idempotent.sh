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

upsert_block() {
  local file="$1"
  local marker_id="$2"
  local content="$3"
  local begin_marker="# BEGIN my-macos-setup:${marker_id}"
  local end_marker="# END my-macos-setup:${marker_id}"

  if ! block_present "$file" "$marker_id"; then
    append_block_if_missing "$file" "$marker_id" "$content"
    return 0
  fi

  local content_file
  content_file=$(mktemp)
  printf '%s\n' "$content" > "$content_file"

  local tmp
  tmp=$(mktemp)
  awk -v begin="$begin_marker" -v end="$end_marker" -v cfile="$content_file" '
    $0 == begin { print; while ((getline line < cfile) > 0) print line; close(cfile); skip=1; next }
    $0 == end { skip=0; print; next }
    !skip { print }
  ' "$file" > "$tmp" && mv "$tmp" "$file"

  rm -f "$content_file"
}
