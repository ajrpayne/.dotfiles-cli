```powershell
cd "$HOME\wsl"

..\github\.dotfiles-cli\wsl\wsl.ps1
wsl -d archlinux

wsl --shutdown
wsl --export archlinux --format tar.gz arch.tar.gz
wsl --unregister archlinux

wsl --update
wsl -l -v
wsl --import arch ./arch arch.tar.gz
wsl -d arch

wsl --shutdown
rm .\arch.tar.gz
wsl --export arch --format tar.gz arch.tar.gz
wsl --unregister arch

wsl --update
wsl -l -v
wsl --import arch ./arch arch.vhdx --vhd
wsl -d arch

wsl --shutdown
rm .\arch.vhdx
wsl --export arch --format vhd arch.vhdx
wsl --unregister arch
```

## missing items

.gitconfig
issue with ssh keys?
ca cert
sudo trust anchor /home/ajrpayne/ca.crt

groups
sudo usermod -aG docker $USER
enable --now docker.socket
