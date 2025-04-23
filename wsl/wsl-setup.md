```powershell
cd "$HOME\wsl"
..\github\.dotfiles-cli\wsl\wsl.ps1
wsl -d archlinux

wsl --shutdown
wsl --export archlinux --format tar.gz arch.tar.gz
wsl --unregister archlinux

wsl --import arch ./arch arch.tar.gz
wsl -d arch
wsl --export arch --format tar.gz arch.tar.gz
wsl --unregister arch
```
