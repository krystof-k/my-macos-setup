#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"

message 'Pre-wipe sync reminder'

message 'Verify iCloud Keychain is fully synced' 'substep' 'to-do'
message 'Verify iCloud Drive is fully synced' 'substep' 'to-do'
message 'Verify Photos library is fully synced' 'substep' 'to-do'
message 'Verify Notes are fully synced' 'substep' 'to-do'
message 'Verify Messages are fully synced' 'substep' 'to-do'
message 'Verify Contacts are fully synced' 'substep' 'to-do'
message 'Verify Calendars are fully synced' 'substep' 'to-do'

sync_apps=(
  "Microsoft OneNote.app:OneNote"
  "Google Chrome.app:Google Chrome"
  "Safari.app:Safari"
  "Bitwarden.app:Bitwarden"
  "Google Drive.app:Google Drive"
)
for entry in "${sync_apps[@]}"; do
  bundle="${entry%%:*}"
  label="${entry#*:}"
  [[ -d "/Applications/$bundle" ]] && message "Verify $label is fully synced" 'substep' 'to-do'
done
