#!/usr/bin/env bash

###########################
# This script installs the dotfiles and runs all other system configuration scripts
###########################

# include my library helpers for colorized echo and require_brew, etc
source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh
source ./lib_sh/sudo.sh

# ###########################################################
# Wallpaper
# ###########################################################
MD5_NEWWP=$(md5 img/wallpaper.png | awk '{print $4}')
MD5_OLDWP=$(md5 "/Library/Desktop Pictures/CustomWallpaper.png" | awk '{print $4}')
if [[ "$MD5_NEWWP" != "$MD5_OLDWP" ]]; then
  read -r -p "Do you want to use the project's custom desktop wallpaper? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]]; then
    running "Set a custom wallpaper image"

    # Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
    # all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
    sudo cp ./img/wallpaper.png "/Library/Desktop Pictures/CustomWallpaper.png"
    rm -rf ~/Library/Application\ Support/Dock/desktoppicture.db
    ls -lah ~/Library/Application\ Support/Dock/desktoppicture.db
    osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Library/Desktop Pictures/CustomWallpaper.png"';ok
    ls -lah ~/Library/Application\ Support/Dock/desktoppicture.db
  else
    ok "skipped"
  fi
fi
