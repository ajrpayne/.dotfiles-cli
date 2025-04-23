```powershell
cd wsl
wsl --update
wsl -l
wsl --unregister

wsl --install archlinux
wsl -d archlinux

passwd
useradd -m -g users -G wheel -s /bin/bash ajrpayne
pacman -Syu
pacman -S sudo
echo "%wheel ALL=(ALL) ALL" >/etc/sudoers.d/wheel
passwd ajrpayne
echo "[user]" >> /etc/wsl.conf
sed -i '/\[user\]/a default=ajrpayne' /etc/wsl.conf
cat /etc/wsl.conf
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
