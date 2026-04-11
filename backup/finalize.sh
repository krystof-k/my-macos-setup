#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"

message 'Finalize'

BACKUP_DIR="${1:-}"
if [[ -z "$BACKUP_DIR" ]]; then
  message 'Backup directory is not set' 'substep' 'prompt'
  exit 1
fi
FAIL_LOG="${FAIL_LOG:-$BACKUP_DIR/failures.log}"

message 'Compute checksums' 'step'
find "$BACKUP_DIR" -type f \
  -not -name checksums.sha256 \
  -not -name index.txt \
  -exec shasum -a 256 {} + \
  > "$BACKUP_DIR/checksums.sha256" 2>/dev/null || true

message 'Write index file' 'step'
{
  echo "Backup Index"
  echo ""
  echo "· Hostname: $(hostname)"
  echo "· Username: $(whoami)"
  echo "· Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "· Script version: $(cd "$(dirname "${BASH_SOURCE[0]}")/.." && git describe --tags --always 2>/dev/null || echo 'unknown')"
  echo ""
  echo "macOS"
  echo ""
  sw_vers 2>/dev/null | while IFS= read -r line; do echo "· $line"; done
  echo ""
  echo "Hardware"
  echo ""
  system_profiler SPHardwareDataType 2>/dev/null | grep -v "^$" | while IFS= read -r line; do echo "· $line"; done
  echo ""
  echo "Disk Layout"
  echo ""
  diskutil list 2>/dev/null | while IFS= read -r line; do echo "· $line"; done
  echo ""
  echo "Failures"
  echo ""
  if [[ -s "$FAIL_LOG" ]]; then
    while IFS= read -r line; do echo "· $line"; done < "$FAIL_LOG"
  else
    echo "None"
  fi
  echo ""
  echo "Captured Files"
  echo ""
  find "$BACKUP_DIR" -type f | sed "s|$BACKUP_DIR/||" | sort | while IFS= read -r line; do echo "· $line"; done
} > "$BACKUP_DIR/index.txt"

total_size=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)
failure_count=0
if [[ -s "$FAIL_LOG" ]]; then
  failure_count=$(wc -l < "$FAIL_LOG" | tr -d ' ')
fi
echo ""
if [[ "$failure_count" -gt 0 ]]; then
  message "Backup complete: ${total_size}, ${failure_count} failure(s) — see failures.log" 'step' 'prompt'
else
  message "Backup complete: ${total_size}, no failures" 'step'
fi
