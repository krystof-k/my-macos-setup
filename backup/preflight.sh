#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"

message 'Preflight check'

message 'Check target path' 'step'
TARGET_PATH="${1:-}"
if [[ -z "$TARGET_PATH" ]]; then
  message 'Target path is not set' 'substep' 'prompt'
  exit 1
fi
if [[ ! -d "$TARGET_PATH" ]]; then
  message "Target path does not exist: $TARGET_PATH" 'substep' 'prompt'
  exit 1
fi
if [[ ! -w "$TARGET_PATH" ]]; then
  message "Target path is not writable: $TARGET_PATH" 'substep' 'prompt'
  exit 1
fi
TARGET_PATH="$(cd "$TARGET_PATH" && pwd)"

message 'Full disk access' 'step'
if plutil -lint /Library/Preferences/com.apple.TimeMachine.plist &>/dev/null; then
  message 'Already granted' 'substep' 'info'
else
  message 'Please enable full disk access for terminal and rerun the backup script' 'substep' 'prompt'
  sleep 2
  open 'x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles'
  exit 1
fi

message 'Estimate backup size' 'step'
total_kb=0
for dir in \
  "$HOME/Library/Preferences" \
  /Library/Preferences \
  "$HOME/Library/Keychains" \
  "$HOME/.config" \
  "$HOME/.ssh" \
  "$HOME/.gnupg" \
  "$HOME/Library/Fonts" \
  "$HOME/Library/LaunchAgents" \
  /Library/LaunchAgents \
  /Library/LaunchDaemons \
  "$HOME/Library/Mail" \
  "$HOME/Library/Containers/com.apple.mail" \
  "$HOME/Library/Containers/at.eggerapps.Postico" \
  "$HOME/Library/Containers/com.wireguard.macos" \
  "$HOME/.claude" \
  "$HOME/.local/share/atuin" \
  "$HOME/Desktop" \
  "$HOME/Documents" \
  "$HOME/Downloads" \
  "$HOME/Screenshots" \
  "$HOME/Git" \
; do
  if [[ -d "$dir" ]]; then
    dir_kb=$(du -sk "$dir" 2>/dev/null | cut -f1)
    total_kb=$(( total_kb + dir_kb ))
  fi
done
for support_dir in \
  AlDente "Docker Desktop" espanso Firefox Lunar Postman PrusaSlicer \
  RedisInsight Slack Spotify com.fournova.Tower3 org.videolan.vlc coconutBattery \
; do
  dir="$HOME/Library/Application Support/$support_dir"
  if [[ -d "$dir" ]]; then
    dir_kb=$(du -sk "$dir" 2>/dev/null | cut -f1)
    total_kb=$(( total_kb + dir_kb ))
  fi
done
estimated_kb=$(( total_kb * 120 / 100 ))
estimated_gb=$(( estimated_kb / 1024 / 1024 ))
available_kb=$(df -k "$TARGET_PATH" | awk 'NR==2{print $4}')
available_gb=$(( available_kb / 1024 / 1024 ))
message "Estimated size is ~${estimated_gb} GB (with 20% headroom)" 'substep' 'info'
message "${available_gb} GB available on target" 'substep' 'info'
if [[ "$estimated_kb" -gt "$available_kb" ]]; then
  message "Not enough space on target volume!" 'substep' 'prompt'
  message "Need ~${estimated_gb} GB, only ${available_gb} GB available." 'substep' 'prompt'
  exit 1
fi
