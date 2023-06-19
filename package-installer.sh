#!/bin/bash

# Preparing system to install packages.
sudo apt update -y && sudo apt upgrade -y
sudo apt install nala -y

# Define function to install packages
install_apt_packages() {
  cat "$1" | xargs sudo apt -y install
}

# Define function to install Flatpak packages
install_flatpak_packages() {
  cat "$1" | xargs -I{} flatpak install --noninteractive --assumeyes {}
}

# Define function to install external packages
install_external_packages() {
  curl -sLf https://spacevim.org/install.sh | bash

}

# Define function to install all .deb packages in a folder
install_all_deb_packages() {
  for package in ~/github/package-installer/deb_package/*.deb; do
    sudo dpkg -i "$package"
  done

  sudo apt --fix-broken install
}

# Install all other packages
install_other_packages(){
 source other_scripts/other_script_handler.sh
}

# Call the function to install packages
install_apt_packages "apt_package_list.txt"

# Call the function to install Flatpak packages
install_flatpak_packages "flatpak_package_list.txt"

# Call the function to install external packages
install_external_packages

# Call the function to install all .deb packages in a folder
install_all_deb_packages

# Call the function to install other packages/ run scripts
install_other_packages
