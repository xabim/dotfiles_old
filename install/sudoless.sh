
  #!/usr/bin/env bash

###########################
# This script installs the dotfiles and runs all other system configuration scripts
# @author Adam Eivy
###########################

# include my library helpers for colorized echo and require_brew, etc
source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh
source ./lib_sh/sudo.sh

question "Do you want me to setup this machine to allow you to run sudo without a password?\nPlease read here to see what I am doing:\nhttp://wiki.summercode.com/sudo_without_a_password_in_mac_os_x \n"

read -r -p "Make sudo passwordless? [y|N] " response
if [[ $response =~ (yes|y|Y) ]];then
    if ! grep -q "#includedir /private/etc/sudoers.d" /etc/sudoers; then
      echo '#includedir /private/etc/sudoers.d' | sudo tee -a /etc/sudoers > /dev/null
    fi
    echo -e "Defaults:$LOGNAME    !requiretty\n$LOGNAME ALL=(ALL) NOPASSWD:     ALL" | sudo tee /etc/sudoers.d/$LOGNAME
    echo "You can now run sudo commands without password!"
fi
