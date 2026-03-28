#!/usr/bin/env bash

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/message.sh"

run() {
  local text="$1"
  shift

  local count=0
  # shellcheck disable=SC2154
  [[ -f "$_msg_counter_file" ]] && count=$(cat "$_msg_counter_file")
  local log_name
  log_name=$(echo "$text" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
  local log_file
  log_file=$(printf ".my-macos-setup/logs/%02d-%s.log" "$(( count + 1 ))" "$log_name")
  mkdir -p .my-macos-setup/logs

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

  local exit_code
  wait "$pid" && exit_code=0 || exit_code=$?

  if [[ $exit_code -eq 0 ]]; then
    _increment_step_count
    echo -e "${GREEN}✔${RESET}  ${text}"
  else
    message "${text} ${GRAY_MED}(see ${log_file})${RESET}" 'error'
    exit "$exit_code"
  fi
}
