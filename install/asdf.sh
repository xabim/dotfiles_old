#!/usr/bin/env bash

###########################
# This script installs the dotfiles and runs all other system configuration scripts
# @author Adam Eivy
###########################

# include my library helpers for colorized echo and require_brew, etc
source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh
source ./lib_sh/sudo.sh

require_brew asdf

running "adding asdf"

if [[ -f "./configs/asdf_plugins" ]]; then
  while IFS= read -r plugin
    do
        asdf plugin-add $plugin
  done < "./configs/asdf_plugins"
fi
