#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/run.sh"

message 'Install HP printer drivers'

if pkgutil --pkg-info com.apple.pkg.HewlettPackardPrinterDrivers &>/dev/null; then
  message 'HP printer drivers already installed' 'substep' 'info'
  # shellcheck disable=SC2317
  return 0 2>/dev/null || exit 0
fi

dmg_url="https://updates.cdn-apple.com/2021/macos/071-46903-20211101-0BD2764A-901C-41BA-9573-C17B8FDC4D90/HewlettPackardPrinterDrivers.dmg"
volume="/Volumes/HP_PrinterSupportManual"
tmp_dir=".my-macos-setup/hp-printer"
mkdir -p "$tmp_dir"

cleanup() {
  hdiutil detach "$volume" 2>/dev/null || true
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

run 'Download HP printer drivers' curl -fSL -o "$tmp_dir/hp.dmg" "$dmg_url"

run 'Patch installer for macOS 15+' bash -c "
  hdiutil attach '$tmp_dir/hp.dmg' -nobrowse -quiet
  pkgutil --expand '$volume/HewlettPackardPrinterDrivers.pkg' '$tmp_dir/hp_pkg'
  hdiutil detach '$volume' -quiet
  sed -i '' 's/system\.compareVersions(system\.version\.ProductVersion, .15\.0.) \&gt; 0/false/' '$tmp_dir/hp_pkg/Distribution'
  pkgutil --flatten '$tmp_dir/hp_pkg' '$tmp_dir/hp_patched.pkg'
"

message 'Authenticate for installation' 'step' 'prompt'
sudo -v
run 'Install HP printer drivers' sudo -n installer -pkg "$tmp_dir/hp_patched.pkg" -target /
