#!/usr/bin/env bash

echo "Enter name of the diff "
read name
mkdir -p "$name"
defaults read > "$name/defaults"
defaults -currentHost read > "$name/host"
read -p "Press enter to continue"
defaults read > "$name/defaults-after"
defaults -currentHost read > "$name/host-after"
