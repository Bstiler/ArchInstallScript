#!/bin/sh

source ./postinstall-vars.sh;
# the file above must contain $HOSTNAME, $FINAL_HOME and $USERNAME

# Basic configs, must be present in every installation
basic_config() {
    sed -i '#/en_US.UTF-8 UTF-8/c\en_US.UTF-8 UTF-8' /etc/locale.gen;
    sed -i '#/pt_BR.UTF-8 UTF-8/c\pt_BR.UTF-8 UTF-8' /etc/locale.gen;
    locale-gen;
    echo LANG=pt_BR.UTF-8 ＞ /etc/locale.conf;
    export LANG=pt_BR.UTF-8;
    ln -s /usr/share/zoneinfo/America/Recife /etc/localtime;
    hwclock --systohc --utc;
    systemctl enable NetworkManager;
    hostnamectl set-hostname $HOSTNAME;
}

# Updates pacman repos
update_repos() {
    dhcpcd;
    pacman -Syyu;
}

# Configures the virtual console
vconsole_config() {
    touch /etc/vconsole.conf;
    echo 'KEYMAP=br-abnt2' >> /etc/vconsole.conf;
    echo 'FONT=Lat2-Terminus16' >> /etc/vconsole.conf;
    echo 'FONT_MAP=' >> /etc/vconsole.conf;
}

# Configures the users
user_config() {
    echo 'Please define a password for the root user:';
    passwd;
    useradd -m -g users -G wheel,storage,power -s /usr/bin/zsh -d $FINAL_HOME $USERNAME;
    echo 'Please define a password for your user:';
    passwd $USERNAME;
}

# Configures sudo
sudo_config() {
    touch /etc/sudoers.d/custom;
    echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers.d/wheel;
}

# Configures grub
grub_config() {
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch;
    grub-mkconfig -o /boot/grub/grub.cfg;
}

# Enables openbox

enable_openbox() {
    systemctl enable lightdm;
    sudo -u $USERNAME mmaker -vf OpenBox3;
}

# Enable Bluetooth

enable_bluetooth() {
    systemctl enable bluetooth;
}