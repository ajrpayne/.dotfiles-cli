```powershell
cd wsl
wsl --update
wsl -l
wsl --unregister

wsl --install archlinux
wsl -d archlinux

ls -lah
../github/.dotfiles-cli/wsl/wsl-user.sh
exit

wsl --terminate archlinux
wsl -l -v
wsl -d archlinux

../github/.dotfiles-cli/wsl/wsl-setup.sh
exit

wsl -d archlinux

nvim
exit

wsl --export archlinux --format tar.gz arch.tar.gz
wsl --unregister archlinux

wsl --import arch ./arch arch.tar.gz
wsl -d arch
wsl --export arch --format tar.gz arch.tar.gz
wsl --unregister arch
```
