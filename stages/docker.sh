#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"

message 'Set up Docker'

if ! command -v docker &>/dev/null; then
  message 'Docker is not installed' 'error'
  # shellcheck disable=SC2317
  return 1 2>/dev/null || exit 1
fi

if docker info &>/dev/null; then
  message 'Docker daemon already running' 'substep' 'info'
else
  message 'Open Docker, wait for the daemon to start and press any key to continue' 'step' 'prompt'
  sleep 2
  open -a Docker
  read -n 1 -s -r
fi

message 'Authenticate GitHub Container registry' 'step'
if grep -q 'ghcr.io' ~/.docker/config.json 2>/dev/null; then
  message 'Already logged in to ghcr.io' 'substep' 'info'
elif [[ -z "${GITHUB_PACKAGES_TOKEN:-}" ]] || [[ -z "${GITHUB_PACKAGES_TOKEN_USERNAME:-}" ]]; then
  message 'GITHUB_PACKAGES_TOKEN or GITHUB_PACKAGES_TOKEN_USERNAME not set' 'error'
  # shellcheck disable=SC2317
  return 1 2>/dev/null || exit 1
else
  echo "$GITHUB_PACKAGES_TOKEN" | docker login ghcr.io -u "$GITHUB_PACKAGES_TOKEN_USERNAME" --password-stdin
fi
