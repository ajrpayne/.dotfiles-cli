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
		xclip \
		zsh \
		nvim \
		git \
		base-devel \
		stow \
		which \
		make \
		zig \
		curl \
		wget \
		tar \
		unzip \
		openssh \
		pyenv \
		python-pip \
		python-pynvim \
		ripgrep \
		lazygit \
		lua51 \
		luarocks \
		go \
		npm \
		gdu \
		bottom \
		tree-sitter-cli \
		fd \
		fzf \
		terraform \
		tmux \
		ldns \
		dos2unix \
		docker \
		docker-buildx \
		docker-compse \
		kubectl \
		kustomize \
		rsync \
		aws-cli-v2 \
		azure-cli \
		jq || {
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

	# Install using yay
	yay -Syu --noconfirm || {
		echo "yay update failed"
		exit 1
	}

	yay -S --noconfirm kind go-yq || {
		echo "yay package installation failed"
		exit 1
	}
}

# Function to set up SSH
setup_ssh() {
	echo "Setting up SSH..."
	mkdir -p ~/.ssh
	chmod 0700 ~/.ssh

	# Copy SSH with error handling
	if ! cp /mnt/c/Users/apayne/.ssh/* ~/.ssh/; then
		echo "Failed to copy SSH"
	else
		chmod 0600 ~/.ssh/*
	fi
}

setup_gitconfig() {
	echo "Setting up .gitconfig..."

	if ! cp /mnt/c/Users/apayne/.gitconfig ~/.gitconfig; then
		echo "Failed to copy .gitconfig"
	else
		chmod 0600 ~/.gitconfig
	fi
}

setup_docker() {
	echo "Setting up docker..."

	groups
	sudo usermod -aG docker "$USER"
	sudo systemctl enable --now docker.socket
}

setup_npm() {
	echo "Setting up npm cafile..."

	if ! npm config set cafile /etc/ssl/certs/ca-certificates.crt; then
		echo "Failed to setup npm cafile"
	fi
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
setup_ssh
setup_gitconfig
setup_docker
setup_npm
setup_dotfiles
change_shell

echo "Setup complete!"
exit 0
