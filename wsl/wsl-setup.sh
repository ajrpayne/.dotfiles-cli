#!/bin/bash

# Function to update the system and install necessary packages
install_packages() {
  echo "Updating system and installing packages..."

  # Update the system and install packages
  sudo pacman -Syu --noconfirm || {
    echo "System update failed"
    exit 1
  }

  sudo pacman -S --noconfirm --needed \
    zsh nvim git base-devel podman kubectl stow which make zig \
    curl wget tar unzip openssh pyenv python-pip python-pynvim \
    ripgrep lazygit lua51 luarocks go npm gdu bottom \
    tree-sitter-cli fd fzf terraform tmux \
    ldns kustomize || {
    echo "Package installation failed"
    exit 1
  }

  # Clone and install yay
  if ! git clone https://aur.archlinux.org/yay-bin.git; then
    echo "Failed to clone yay-bin repository"
    exit 1
  fi

  cd yay-bin || exit 1
  makepkg -si --noconfirm || {
    echo "Failed to install yay"
    exit 1
  }

  cd ~ || exit 1

  # Install kind using yay
  yay -S --noconfirm kind go-yq || {
    echo "Failed to install kind"
    exit 1
  }
}

# Function to set up dotfiles
setup_dotfiles() {
  echo "Cloning dotfiles repository..."

  if ! git clone https://github.com/ajrpayne/.dotfiles-cli.git ~/.dotfiles-cli; then
    echo "Failed to clone dotfiles repository"
    exit 1
  fi

  cd ~/.dotfiles-cli || {
    echo "Failed to enter .dotfiles-cli directory"
    exit 1
  }

  echo "Initializing and updating submodules..."
  git submodule update --init || {
    echo "Failed to update submodules"
    exit 1
  }

  echo "Stowing dotfiles..."
  stow zsh nvim.astro || {
    echo "Failed to stow dotfiles"
    exit 1
  }

  cd ~ || exit 1
}

# Function to set up SSH keys
setup_ssh() {
  echo "Setting up SSH keys..."
  mkdir -p ~/.ssh
  chmod 0700 ~/.ssh

  # Copy SSH keys with error handling
  if ! cp /mnt/c/Users/apayne/.ssh/* ~/.ssh/; then
    echo "Failed to copy SSH keys"
    exit 1
  fi

  chmod 0600 ~/.ssh/*
}

# Function to change the default shell to zsh
change_shell() {
  echo "Changing default shell to zsh..."
  if ! chsh -s /bin/zsh; then
    echo "Failed to change shell"
    exit 1
  fi
}

# Main script execution
cd ~ || exit 1
install_packages
setup_dotfiles
setup_ssh
change_shell

echo "Setup complete! Please log out and log back in for changes to take effect."
exit 0
