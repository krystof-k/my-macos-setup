#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/helpers.sh"

message 'Raw dumps'

PHASE_DIR="${1:-}"
if [[ -z "$PHASE_DIR" ]]; then
  message 'Backup directory is not set' 'substep' 'prompt'
  exit 1
fi
mkdir -p "$PHASE_DIR"
FAIL_LOG="${FAIL_LOG:-$PHASE_DIR/failures.log}"

message 'Preferences' 'step'
try_copy "$HOME/Library/Preferences" preferences
try_copy --sudo /Library/Preferences global-preferences

message 'Defaults' 'step'
try_cmd defaults/domains.txt defaults domains
try_cmd defaults/currentHost-domains.txt defaults -currentHost domains
try_cmd defaults/all.txt defaults read

message 'Keychain inventory' 'step'
try_cmd keychain/list.txt security list-keychains
try_cmd keychain/metadata.txt security dump-keychain login.keychain-db

message 'TCC permissions' 'step'
try_cmd tcc/user.csv sqlite3 -header -csv "$HOME/Library/Application Support/com.apple.TCC/TCC.db" "SELECT service, client, auth_value, auth_reason FROM access ORDER BY service, client"
try_cmd tcc/system.csv sudo sqlite3 -header -csv "/Library/Application Support/com.apple.TCC/TCC.db" "SELECT service, client, auth_value, auth_reason FROM access ORDER BY service, client"

message 'Full ~/.config' 'step'
try_copy "$HOME/.config" dot-config

message 'Shell history' 'step'
try_copy "$HOME/.zsh_history" dot-zsh_history.txt
try_copy "$HOME/.bash_history" dot-bash_history.txt
try_copy "$HOME/.local/share/atuin" dot-local-share-atuin
