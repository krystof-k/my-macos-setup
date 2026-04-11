#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/helpers.sh"

message 'Dumps'

PHASE_DIR="${1:-}"
if [[ -z "$PHASE_DIR" ]]; then
  message 'Backup directory is not set' 'substep' 'prompt'
  exit 1
fi
mkdir -p "$PHASE_DIR"
FAIL_LOG="${FAIL_LOG:-$PHASE_DIR/failures.log}"

message 'Keyboard and input settings' 'step'
try_copy "$HOME/Library/Preferences/com.apple.symbolichotkeys.plist" keyboard-shortcuts.plist
try_cmd text-replacements.plist defaults read -g NSUserDictionaryReplacementItems
try_cmd input-sources.plist defaults read com.apple.HIToolbox AppleEnabledInputSources

message 'Login items' 'step'
try_cmd login-items.txt osascript -e 'tell application "System Events" to get the name of every login item'

message 'System configuration' 'step'
try_cmd etc-hosts sudo cat /etc/hosts
try_copy --sudo /etc/pam.d/sudo_local sudo_local
try_copy --sudo /etc/resolver etc-resolver

message 'Firewall rules' 'step'
try_cmd firewall-rules.txt sudo /usr/libexec/ApplicationFirewall/socketfilterfw --listapps

message 'Spotlight exclusions' 'step'
try_cmd spotlight-status.txt mdutil -s /

message 'Time Machine exclusions' 'step'
try_cmd timemachine-exclusions.txt defaults read /Library/Preferences/com.apple.TimeMachine

message 'Security state' 'step'
try_cmd security/filevault.txt fdesetup status
try_cmd security/gatekeeper.txt spctl --status
try_cmd security/sip.txt csrutil status
try_cmd security/apfs.txt diskutil apfs list
try_cmd security/enrollment.txt profiles status -type enrollment

message 'System info' 'step'
try_cmd system/software.txt system_profiler SPSoftwareDataType
try_cmd system/storage.txt system_profiler SPStorageDataType
try_cmd system/users.txt dscl . list /Users
try_cmd system/groups.txt dscl . list /Groups

message 'Power settings' 'step'
try_cmd power-settings.txt pmset -g custom

