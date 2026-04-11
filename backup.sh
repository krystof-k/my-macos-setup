#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/utilities/message.sh"

usage() {
  echo "Usage: backup.sh [--dry-run] <target-path>"
  echo ""
  echo "Back up the current machine state to an external drive."
  echo ""
  echo "Options:"
  echo "  --dry-run   Run preflight checks and estimate size, but write nothing"
  echo "  -h, --help  Show this help message"
  echo ""
  echo "Examples:"
  echo "  ./backup.sh /Volumes/MySSD"
  echo "  ./backup.sh --dry-run /Volumes/MySSD"
  exit "${1:-0}"
}

DRY_RUN=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    -h|--help) usage ;;
    -*) echo "Unknown option: $1"; echo ""; usage 1 ;;
    *) TARGET_PATH="$1"; shift ;;
  esac
done

[[ -z "${TARGET_PATH:-}" ]] && usage 1

header 'backup'
echo -e ""
echo -e "${GRAY_MED}This backup will contain private keys, credentials, and shell history!${RESET}"

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/backup/preflight.sh" "$TARGET_PATH"

BACKUP_DIR="$TARGET_PATH/macos-backup-$(date +%Y-%m-%d)"
message "Backup will be saved to \`$BACKUP_DIR\`" 'substep' 'info'

if [[ "$DRY_RUN" == 1 ]]; then
  footer 'Dry run complete. No files were written.'
  exit 0
fi

footer
