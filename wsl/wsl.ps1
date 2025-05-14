cd "$HOME\wsl"

wsl --update
wsl -l -v
wsl --install archlinux
wsl -d archlinux ls -lah
wsl -d archlinux ../github/.dotfiles-cli/wsl/wsl-user.sh
wsl --terminate archlinux
wsl -l -v
wsl -d archlinux ../github/.dotfiles-cli/wsl/wsl-setup.sh
wsl --terminate archlinux
wsl -l -v
wsl -d archlinux
