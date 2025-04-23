```powershell
cd "$HOME\wsl"

wsl --export archlinux --format tar.gz arch.tar.gz
wsl --unregister archlinux

wsl --import arch ./arch arch.tar.gz
wsl -d arch
wsl --export arch --format tar.gz arch.tar.gz
wsl --unregister arch
```
