# Basic configs, must be present in every installation
basic_config() {
    echo "#\!/bin/sh" >> $1;
    echo "" >> $1;
    echo "sed -i '#/en_US.UTF-8 UTF-8/c\en_US.UTF-8 UTF-8' /etc/locale.gen;" >> $1;
    echo "sed -i '#/pt_BR.UTF-8 UTF-8/c\pt_BR.UTF-8 UTF-8' /etc/locale.gen;" >> $1;
    echo "locale-gen;" >> $1;
    echo "echo LANG=pt_BR.UTF-8 ＞ /etc/locale.conf;" >> $1;
    echo "export LANG=pt_BR.UTF-8;" >> $1;
    echo "ln -s /usr/share/zoneinfo/America/Recife /etc/localtime;" >> $1;
    echo "hwclock --systohc --utc;" >> $1;
    echo "systemctl enable NetworkManager;" >> $1;
    echo "hostnamectl set-hostname $HOSTNAME" >> $1;
}

# Updates pacman repos
update_repos() {
    echo "dhcpcd;" >> $1;
    echo "pacman -Syyu;" >> $1;
}

# Configures the virtual console
vconsole_config() {
    echo "touch /etc/vconsole.conf;" >> $1;
    echo "echo 'KEYMAP=br-abnt2' >> /etc/vconsole.conf;" >> $1;
    echo "echo 'FONT=Lat2-Terminus16' >> /etc/vconsole.conf;" >> $1;
    echo "echo 'FONT_MAP=' >> /etc/vconsole.conf;" >> $1;
}

# Configures the users
user_config() {
    echo "echo 'Please define a password for the root user:';" >> $1;
    echo "passwd;" >> $1;
    echo "useradd -m -g users -G wheel,storage,power -s /usr/bin/zsh -d $FINAL_HOME $USERNAME;" >> $1;
    echo "echo 'Please define a password for your user:';" >> $1;
    echo "passwd $USERNAME;" >> $1;
}

# Configures sudo
sudo_config() {
    echo "touch /etc/sudoers.d/custom" >> $1;
    echo "echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers.d/wheel" >> $1;
}

# Configures grub
grub_config() {
    echo "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch" >> $1;
    echo "grub-mkconfig -o /boot/grub/grub.cfg" >> $1;
}

# Enables openbox

enable_openbox() {
    echo "systemctl enable lightdm" >> $1;
    echo "mmaker -vf OpenBox3" >> $1;
}