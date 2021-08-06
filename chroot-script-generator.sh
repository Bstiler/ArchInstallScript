# Create Sub-script

touch /tmp/chroot-script.sh

# Base System Settings

echo "#\!/bin/sh" >> /tmp/chroot-script.sh;
echo "" >> /tmp/chroot-script.sh;
echo "sed -i '#/en_US.UTF-8 UTF-8/c\en_US.UTF-8 UTF-8' /etc/locale.gen;" >> /tmp/chroot-script.sh;
echo "sed -i '#/pt_BR.UTF-8 UTF-8/c\pt_BR.UTF-8 UTF-8' /etc/locale.gen;" >> /tmp/chroot-script.sh;
echo "locale-gen;" >> /tmp/chroot-script.sh;
echo "echo LANG=pt_BR.UTF-8 ＞ /etc/locale.conf;" >> /tmp/chroot-script.sh;
echo "export LANG=pt_BR.UTF-8;" >> /tmp/chroot-script.sh;
echo "ln -s /usr/share/zoneinfo/America/Recife /etc/localtime;" >> /tmp/chroot-script.sh;
echo "hwclock --systohc --utc;" >> /tmp/chroot-script.sh;
echo "systemctl enable dhcpcd@eth0.service;" >> /tmp/chroot-script.sh;
echo "pacman -Syu;" >> /tmp/chroot-script.sh;
echo "pacman -S wireless_tools wpa_supplicant wpa_actiond netcf dialog sudo zsh grub efibootmgr;" >> /tmp/chroot-script.sh;
echo "systemctl enable net-auto-wireless.service;" >> /tmp/chroot-script.sh;
echo "touch /etc/vconsole.conf;" >> /tmp/chroot-script.sh;
echo "echo 'KEYMAP=br-abnt2' >> /etc/vconsole.conf;" >> /tmp/chroot-script.sh;
echo "echo 'FONT=Lat2-Terminus16' >> /etc/vconsole.conf;" >> /tmp/chroot-script.sh;
echo "echo 'FONT_MAP=' >> /etc/vconsole.conf;" >> /tmp/chroot-script.sh;
echo "echo 'Please define a password for the root user:';" >> /tmp/chroot-script.sh;
echo "passwd;" >> /tmp/chroot-script.sh;
echo "useradd -m -g users -G wheel,storage,power,sudo -s /usr/bin/zsh -d $FINAL_HOME $USERNAME;" >> /tmp/chroot-script.sh;
echo "echo 'Please define a password for your user:';" >> /tmp/chroot-script.sh;
echo "passwd $USERNAME;" >> /tmp/chroot-script.sh;
echo "touch /etc/sudoers.d/wheel" >> /tmp/chroot-script.sh;
echo "echo '%sudo ALL=(ALL) ALL' /etc/sudoers.d/wheel>> " >> /tmp/chroot-script.sh;
echo "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch" >> /tmp/chroot-script.sh;
echo "grub-mkconfig -o /boot/grub/grub.cfg" >> /tmp/chroot-script.sh;
echo "" >> /tmp/chroot-script.sh;
echo "" >> /tmp/chroot-script.sh;

chmod +x /tmp/chroot-script.sh;