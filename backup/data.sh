#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/helpers.sh"

message 'Configuration data'

PHASE_DIR="${1:-}"
if [[ -z "$PHASE_DIR" ]]; then
  message 'Backup directory is not set' 'substep' 'prompt'
  exit 1
fi
mkdir -p "$PHASE_DIR"
FAIL_LOG="${FAIL_LOG:-$PHASE_DIR/failures.log}"

message 'Shell configs' 'step'
for f in .zshrc .zprofile .zshenv .zcompdump .bashrc .bash_profile .profile; do
  try_copy "$HOME/$f" "shell/dot-${f#.}.txt"
done
try_copy "$HOME/.zfunc" shell/dot-zfunc
try_copy "$HOME/.zsh_sessions" shell/dot-zsh_sessions

message 'Git config' 'step'
try_copy "$HOME/.gitconfig" git/dot-gitconfig.txt
try_copy "$HOME/.gitignore" git/dot-gitignore.txt

message 'Package manager configs' 'step'
try_copy "$HOME/.npmrc" configs/dot-npmrc.txt
try_copy "$HOME/.yarnrc" configs/dot-yarnrc.txt
try_copy "$HOME/.yarnrc.yml" configs/dot-yarnrc.yml
try_copy "$HOME/.bundle/config" configs/dot-bundle-config.txt

message 'Claude Code config' 'step'
if [[ -d "$HOME/.claude" ]]; then
  message "\`~/.claude\`" 'substep'
  mkdir -p "$PHASE_DIR/claude"
  if ! tar czf "$PHASE_DIR/claude/dot-claude.tar.gz" -C "$HOME" .claude 2>/dev/null; then
    rm -f "$PHASE_DIR/claude/dot-claude.tar.gz"
    echo "FAILED: compress ~/.claude -> claude/dot-claude.tar.gz" >> "$FAIL_LOG"
    # shellcheck disable=SC2016
    message 'Failed: `claude/dot-claude.tar.gz`' 'substep' 'prompt'
  fi
fi
try_copy "$HOME/.claude.json" claude/dot-claude.json

message 'VS Code settings' 'step'
vscode_user="$HOME/Library/Application Support/Code/User"
try_copy "$vscode_user/settings.json" vscode/settings.json
try_copy "$vscode_user/keybindings.json" vscode/keybindings.json
try_copy "$vscode_user/snippets" vscode/snippets

message 'Fonts' 'step'
try_copy "$HOME/Library/Fonts" fonts/

message 'Launch Agents and Daemons' 'step'
try_copy "$HOME/Library/LaunchAgents" launch/agents-user
try_copy --sudo /Library/LaunchAgents launch/agents-system
try_copy --sudo /Library/LaunchDaemons launch/daemons

message 'Mail' 'step'
mkdir -p "$PHASE_DIR/mail"
for mail_dir in "$HOME/Library/Mail" "$HOME/Library/Containers/com.apple.mail"; do
  if [[ -d "$mail_dir" ]]; then
    archive_name="$(basename "$mail_dir").tar.gz"
    message "\`${mail_dir}\`" 'substep'
    if ! tar czf "$PHASE_DIR/mail/$archive_name" -C "$(dirname "$mail_dir")" "$(basename "$mail_dir")" 2>/dev/null; then
      rm -f "$PHASE_DIR/mail/$archive_name"
      echo "FAILED: compress $mail_dir -> mail/$archive_name" >> "$FAIL_LOG"
      # shellcheck disable=SC2016
      message "Failed: \`mail/${archive_name}\`" 'substep' 'prompt'
    fi
  else
    message "Skipped (not found): \`${mail_dir}\`" 'substep'
  fi
done

message 'Application data' 'step'
app_support_map=(
  "AlDente.app:AlDente"
  "Docker.app:Docker Desktop"
  "Espanso.app:espanso"
  "Firefox.app:Firefox"
  "Lunar.app:Lunar"
  "Postman.app:Postman"
  "PrusaSlicer.app:PrusaSlicer"
  "Redis Insight.app:RedisInsight"
  "Slack.app:Slack"
  "Spotify.app:Spotify"
  "Tower.app:com.fournova.Tower3"
  "VLC.app:org.videolan.vlc"
  "coconutBattery.app:coconutBattery"
)
for entry in "${app_support_map[@]}"; do
  app_name="${entry%%:*}"
  support_dir="${entry#*:}"
  if [[ -d "/Applications/$app_name" ]] || [[ -d "$HOME/Applications/$app_name" ]]; then
    src="$HOME/Library/Application Support/$support_dir"
    [[ -d "$src" ]] && try_copy "$src" "ApplicationSupport/$support_dir"
  fi
done
try_copy "$HOME/.redis-insight" ApplicationSupport/dot-redis-insight
try_copy "$HOME/Library/Containers/at.eggerapps.Postico" ApplicationSupport/postico-container
try_copy "$HOME/Library/Safari/Bookmarks.plist" ApplicationSupport/safari-bookmarks.plist

message 'macOS user data' 'step'
try_copy "$HOME/Library/Spelling/LocalDictionary" macos/LocalDictionary.txt

message 'Network and VPN' 'step'
try_copy "$HOME/Library/Containers/com.wireguard.macos" network/wireguard-container
try_cmd network/network-services.txt networksetup -listallnetworkservices
try_cmd network/network-service-order.txt networksetup -listnetworkserviceorder
try_cmd network/proxy-settings.txt scutil --proxy
try_cmd network/dns-config.txt scutil --dns
try_cmd network/ifconfig.txt ifconfig

message 'User directories' 'step'
for dir in Desktop Documents Downloads Screenshots; do
  [[ ! -d "$HOME/$dir" ]] && continue
  message "\`~/$dir\`" 'substep'
  mkdir -p "$PHASE_DIR/directories/$dir"
  if /opt/homebrew/bin/rsync --version &>/dev/null 2>&1; then
    /opt/homebrew/bin/rsync -rlt --no-specials --inplace --info=progress2 "$HOME/$dir/" "$PHASE_DIR/directories/$dir/" 2>/dev/null || true
  else
    rsync -rlt --no-specials --inplace "$HOME/$dir/" "$PHASE_DIR/directories/$dir/" >/dev/null 2>&1 || true
  fi
done

message 'Compress ~/Git' 'step'
if [[ -d "$HOME/Git" ]]; then
  message 'This may take a while…' 'substep' 'info'
  tar czf "$PHASE_DIR/Git.tar.gz" -C "$HOME" Git 2>/dev/null || message 'Failed to compress ~/Git' 'substep' 'prompt'
fi
