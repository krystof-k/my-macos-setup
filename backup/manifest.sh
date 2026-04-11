#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/helpers.sh"

message 'Inventories and listings'

PHASE_DIR="${1:-}"
if [[ -z "$PHASE_DIR" ]]; then
  message 'Backup directory is not set' 'substep' 'prompt'
  exit 1
fi
mkdir -p "$PHASE_DIR"
FAIL_LOG="${FAIL_LOG:-$PHASE_DIR/failures.log}"

message 'Application listings' 'step'

try_cmd applications.txt ls "$HOME/Applications"
try_cmd applications-global.txt ls /Applications

if command -v brew &>/dev/null; then
  message 'Homebrew packages' 'step'
  try_cmd homebrew/Brewfile.txt brew bundle dump --file=-
  try_cmd homebrew/list.txt brew list --versions
  try_cmd homebrew/taps.txt brew tap
  try_cmd homebrew/services.txt brew services list
fi

if command -v mas &>/dev/null; then
  message 'Mac App Store apps' 'step'
  try_cmd mas-list.txt mas list
fi

if [[ -n "${NVM_DIR:-}" ]] && [[ -s "$NVM_DIR/nvm.sh" ]]; then
  message 'Node.js inventory' 'step'
  # shellcheck disable=SC1091
  source "$NVM_DIR/nvm.sh"
  try_cmd node/versions.txt nvm ls
  for version_dir in "$NVM_DIR"/versions/node/*/; do
    [[ ! -d "$version_dir" ]] && continue
    version_dir="${version_dir%/}"
    v="$(basename "$version_dir")"
    [[ -x "$version_dir/bin/npm" ]] && try_cmd "node/${v}-npm-global.txt" "$version_dir/bin/npm" list -g --depth=0
    [[ -x "$version_dir/bin/yarn" ]] && try_cmd "node/${v}-yarn-global.txt" "$version_dir/bin/yarn" global list
  done
fi
command -v pnpm &>/dev/null && try_cmd node/pnpm-global.txt pnpm list -g

if command -v pyenv &>/dev/null; then
  message 'Python inventory' 'step'
  try_cmd python/versions.txt pyenv versions --bare
  while IFS= read -r v; do
    [[ -z "$v" ]] && continue
    [[ -L "$HOME/.pyenv/versions/$v" ]] && continue  # skip virtualenv symlinks
    [[ -x "$HOME/.pyenv/versions/$v/bin/pip" ]] && try_cmd "python/${v}-freeze.txt" "$HOME/.pyenv/versions/$v/bin/pip" freeze
  done < <(pyenv versions --bare 2>/dev/null)
  command -v pipx &>/dev/null && try_cmd python/pipx.txt pipx list
fi

if command -v rbenv &>/dev/null; then
  message 'Ruby inventory' 'step'
  try_cmd ruby/versions.txt rbenv versions --bare
  while IFS= read -r v; do
    [[ -z "$v" ]] && continue
    [[ -x "$HOME/.rbenv/versions/$v/bin/gem" ]] && try_cmd "ruby/${v}-gems.txt" "$HOME/.rbenv/versions/$v/bin/gem" list
  done < <(rbenv versions --bare 2>/dev/null)
fi

if command -v code &>/dev/null; then
  message 'VS Code extensions' 'step'
  try_cmd vscode-extensions.txt code --list-extensions --show-versions
fi

message 'Printers' 'step'
try_cmd printers.txt lpstat -a

message 'System extensions' 'step'
try_cmd system-extensions.txt systemextensionsctl list

if command -v docker &>/dev/null; then
  message 'Docker state' 'step'
  try_cmd docker/images.txt docker image ls
  try_cmd docker/containers.txt docker ps -a
  try_cmd docker/volumes.txt docker volume ls
fi

if [[ -d "$HOME/Git" ]]; then
  message 'Git repositories' 'step'
  while IFS= read -r repo; do
    name="${repo#"$HOME/Git/"}"
    try_cmd "git-repos/${name}-branches.txt" git -C "$repo" branch -a
    try_cmd "git-repos/${name}-remotes.txt" git -C "$repo" remote -v
  done < <(find "$HOME/Git" -name .git -type d -maxdepth 3 2>/dev/null | sed 's|/\.git$||')
fi

message 'Directory listings' 'step'
for dir in Desktop Documents Downloads Screenshots; do
  if [[ -d "$HOME/$dir" ]]; then
    if command -v tree &>/dev/null; then
      try_cmd "directories/${dir}.txt" tree "$HOME/$dir"
    else
      try_cmd "directories/${dir}.txt" find "$HOME/$dir" -not -path '*/.*'
    fi
  fi
done
