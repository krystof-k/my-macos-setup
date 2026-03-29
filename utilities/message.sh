#!/usr/bin/env bash

BOLD=$(tput bold)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
GRAY_DARK=$(tput setaf 240)
GRAY_MED=$(tput setaf 244)
GRAY_LIGHT=$(tput setaf 248)

RESET=$(tput sgr0)

EL=$(tput el)
SUDO_PROMPT="$(echo -e "\r${GRAY_DARK}│${RESET}  ${YELLOW}›${RESET} Password: ${EL}")"
export SUDO_PROMPT

if [[ -z "${_msg_counter_file:-}" ]]; then
  export _msg_counter_file=".my-macos-setup/step-count"
fi

_increment_step_count() {
  mkdir -p .my-macos-setup
  local count=0
  [[ -f "$_msg_counter_file" ]] && count=$(cat "$_msg_counter_file")
  echo $(( count + 1 )) > "$_msg_counter_file"
}

setup_header() {
  rm -f "$_msg_counter_file"
  _msg_start_time=$(date +%s)
  echo ""
  echo -e "${BOLD} My macOS setup${RESET}"
}

setup_footer() {
  local end_time count elapsed minutes seconds
  end_time=$(date +%s)
  count=0
  [[ -f "$_msg_counter_file" ]] && count=$(cat "$_msg_counter_file")
  rm -f "$_msg_counter_file"
  elapsed=$(( end_time - _msg_start_time ))
  minutes=$(( elapsed / 60 ))
  seconds=$(( elapsed % 60 ))
  echo ""
  if (( minutes > 0 )); then
    message "Done! ${GRAY_MED}(${count} steps in ${minutes}m ${seconds}s)${RESET}" 'step'
  else
    message "Done! ${GRAY_MED}(${count} steps in ${seconds}s)${RESET}" 'step'
  fi
  message 'Please reboot and complete manual steps from the to-do list (to-do.txt)' 'substep' 'info'
  echo ""
}

message() {
  local text="$1"
  local level="${2:-}"
  local modifier="${3:-}"

  if [[ -z "$level" ]]; then
    echo ""
    echo -e "${BOLD}${text}${RESET}"
    return
  fi

  if [[ "$level" == 'step' ]]; then
    if [[ "$modifier" == 'prompt' ]]; then
      echo -e "${YELLOW}?${RESET}  ${text}"
    else
      _increment_step_count
      echo -e "${GREEN}✔${RESET}  ${text}"
    fi
    return
  fi

  if [[ "$level" == 'substep' ]]; then
    if [[ "$modifier" == 'prompt' ]]; then
      echo -e "${GRAY_DARK}│${RESET}  ${YELLOW}›${RESET} ${text}"
    elif [[ "$modifier" == 'info' ]]; then
      echo -e "${GRAY_DARK}│${RESET}  ${GRAY_LIGHT}${text}${RESET}"
    elif [[ "$modifier" == 'to-do' ]]; then
      echo -e "${GRAY_DARK}│${RESET}  ${YELLOW}○${RESET} ${text} ${GRAY_DARK}(added to to-do list)${RESET}"
      if ! grep -qF "$text" ./to-do.txt 2>/dev/null; then
        echo "○ ${text}" >> ./to-do.txt
      fi
    else
      echo -e "${GRAY_DARK}│${RESET}  ${GRAY_MED}·${RESET} ${GRAY_LIGHT}${text}${RESET}"
    fi
    return
  fi

  if [[ "$level" == 'info' ]]; then
    echo -e "${GRAY_MED}·  ${text}${RESET}"
    return
  fi

  if [[ "$level" == 'prompt' ]]; then
    echo -e "${YELLOW}?${RESET}  ${text}"
    return
  fi

  if [[ "$level" == 'error' ]]; then
    echo -e "${RED}✗${RESET}  ${text}"
    return
  fi
}
