# macOS 27 Golden Gate upgrade checklist

Announced at WWDC on June 8, 2026; ships as a free update in fall 2026 (likely September/October). Apple Silicon only (M1+). Findings below are from research on 2026-07-03 — verify against release notes before upgrading.

## Before upgrading

- [ ] Audit what still needs Rosetta 2 (x86-only casks, tools) — general Rosetta support **ends with macOS 28** (fall 2027), Golden Gate is the last full release ([Apple](https://support.apple.com/en-us/102527))
- [ ] Run `backup.sh`

## After upgrading

- [ ] **Rosetta**: the macOS 27 installer reportedly removes a previously installed Rosetta 2 — rerun the setup (the apps stage reinstalls it; `--agree-to-license` is broken since Tahoe, the stage falls back to `--quiet`)
- [ ] **Spotlight exclusions** (`preferences/global.sh`): Spotlight search is rebuilt in macOS 27 — verify the direct `VolumeConfiguration.plist` edit still works; fall back to `mdutil` / System Settings Privacy list if not
- [ ] **`defaults` domains**: macOS 27 revises the Liquid Glass UI again (toolbars, sidebars, transparency slider) — re-verify dock/finder/controlcenter/NSGlobalDomain keys with `utilities/defaults-diff.sh`
- [ ] **HP printer drivers** (`stages/hp-printer.sh`): the 2021 pkg + Distribution patch works on Tahoe but macOS is moving to driverless AirPrint — test printing, consider switching to AirPrint/IPP Everywhere
- [ ] **`activateSettings -u`** (`preferences/keyboard-shortcuts.sh`, Tower3): private framework binary — confirm it still exists
- [ ] **Touch ID for sudo**: `/etc/pam.d/sudo_local` survives upgrades by design — just confirm
- [ ] **Homebrew**: macOS 27 starts at Tier 2 until promoted to Tier 1 — expect some casks/bottles to lag right after release

## Not affected

- AFP and Boot Camp are removed in macOS 27 — not used here
- Homebrew on Apple Silicon stays Tier 1; the Intel wind-down is irrelevant for the M5
