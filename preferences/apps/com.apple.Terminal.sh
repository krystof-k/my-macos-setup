#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure Terminal' 'step'

message 'Disable Option as Meta key' 'substep'
/usr/libexec/PlistBuddy -c "Set ':Window Settings:Clear Dark:useOptionAsMetaKey' false" ~/Library/Preferences/com.apple.Terminal.plist 2>/dev/null \
  || /usr/libexec/PlistBuddy -c "Add ':Window Settings:Clear Dark:useOptionAsMetaKey' bool false" ~/Library/Preferences/com.apple.Terminal.plist
