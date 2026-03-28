#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../utilities/message.sh"

message 'Set Windows-like (option ⌥ + tab ⇥) keyboard shortcut for switching app windows' 'step'
/usr/libexec/PlistBuddy -c 'Delete :AppleSymbolicHotKeys:27' ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27 dict' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:enabled bool true' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value dict' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value:type string standard' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value:parameters array' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value:parameters:0 integer 65535' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value:parameters:1 integer 48' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value:parameters:2 integer 524288' ~/Library/Preferences/com.apple.symbolichotkeys.plist
defaults read com.apple.symbolichotkeys.plist > /dev/null # reload plist file
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u # apply preferences
