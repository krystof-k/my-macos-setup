#!/usr/bin/env bash

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/message.sh"

run() {
  local text="$1"
  shift

  local log_name
  log_name=$(echo "$text" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
  local log_file=".setup/logs/${log_name}.log"
  mkdir -p .setup/logs

  "$@" > "$log_file" 2>&1 &
  local pid=$!

  local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf "\r${YELLOW}%s${RESET}  %s" "${spin:i++%${#spin}:1}" "$text"
    sleep 0.1
  done

  printf "\r"
  tput el

  wait "$pid"
  local exit_code=$?

  if [[ $exit_code -eq 0 ]]; then
    _increment_step_count
    echo -e "${GREEN}✔${RESET}  ${text}"
  else
    message "${text} ${GRAY_MED}(see ${log_file})${RESET}" 'error'
    exit "$exit_code"
  fi
}
