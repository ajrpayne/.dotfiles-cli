#!/bin/bash

setup_ca() {
  echo "Setting up ca..."

  if ! cp /mnt/c/Users/apayne/ca.crt /opt/ca.crt; then
    echo "Failed to copy ca"
  else
    trust anchor /opt/ca.crt
    update-ca-trust
  fi
}
#setup_ca

# Update the package database and upgrade all packages
pacman -Syu --noconfirm

# Install the sudo package
pacman -S --noconfirm --needed sudo

# Set a password for the root user (ensure to replace 'your_password' with a secure password)
passwd

sed -i 's/^#en_CA\.UTF-8 UTF-8$/en_CA.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#en_US\.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/' /etc/locale.gen
grep "en_CA.UTF-8" /etc/locale.gen
grep "en_US.UTF-8" /etc/locale.gen
locale-gen
locale -a
localectl set-locale LANG=en_CA.UTF-8
unset LANG
source /etc/profile.d/locale.sh
locale

# Create a new user 'ajrpayne' with a home directory, primary group 'users', additional group 'wheel', and default shell '/bin/bash'
useradd -m -g users -G wheel -s /bin/bash ajrpayne

# Allow members of the 'wheel' group to execute any command using sudo
echo "%wheel ALL=(ALL) ALL" >/etc/sudoers.d/wheel

# Set a password for the new user 'ajrpayne'
passwd ajrpayne

# Configure WSL to use the new user by default
echo "[user]" >>/etc/wsl.conf
sed -i '/\[user\]/a default=ajrpayne' /etc/wsl.conf

# Display the contents of the wsl.conf file to verify changes
cat /etc/wsl.conf
