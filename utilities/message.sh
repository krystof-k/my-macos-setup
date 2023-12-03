#!/bin/bash

BOLD=$(tput bold)
WHITE=$(tput setaf 7)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
OFF=$(tput sgr0 && tput sgr0)

message () {
  if [ "$2" == 'step' ]; then
    MESSAGE="  $1"
  elif [ "$2" == 'substep' ]; then
    MESSAGE="    $1"
  else
    MESSAGE="${BOLD}$1${OFF}"
  fi

  if [ "$2" == 'prompt' ] || [ "$3" == 'prompt' ]; then
    echo -e "${RED}${OFF} ${MESSAGE}"
  elif [ "$2" == 'info' ] || [ "$3" == 'info' ]; then
    echo -e "${WHITE}${OFF} ${MESSAGE}"
  elif [ "$2" == 'to-do' ] || [ "$3" == 'to-do' ]; then
    echo -e "${YELLOW}${OFF} ${MESSAGE} (added to to-do.txt)"
    echo -e " ${MESSAGE}" >> ./to-do.txt
  else
    echo -e " ${MESSAGE}"
  fi
}
