```powershell
cd "$HOME\wsl"

..\github\.dotfiles-cli\wsl\wsl.ps1

# tar.gz
wsl --update
wsl -l -v
wsl --import arch ./arch arch.tar.gz
wsl -d arch

wsl --shutdown
rm .\arch.tar.gz
wsl --export arch --format tar.gz arch.tar.gz
wsl --unregister arch

# vhd
wsl --update
wsl -l -v
wsl --import arch ./arch arch.vhdx --vhd
wsl -d arch

wsl --shutdown
rm .\arch.vhdx
wsl --export arch --format vhd arch.vhdx
wsl --unregister arch
```
