# Create Sub-script

generate_chroot_script() {
    if [ ! $1 ]
    then
        export CHROOT_SCRIPT_PATH=/tmp/chroot-script.sh;
    else
        export CHROOT_SCRIPT_PATH=$1;
    fi

    touch $CHROOT_SCRIPT_PATH;

    echo "#\!/bin/sh" >> $CHROOT_SCRIPT_PATH;
    echo "" >> $CHROOT_SCRIPT_PATH;
    echo "sed -i '#/en_US.UTF-8 UTF-8/c\en_US.UTF-8 UTF-8' /etc/locale.gen;" >> $CHROOT_SCRIPT_PATH;
    echo "sed -i '#/pt_BR.UTF-8 UTF-8/c\pt_BR.UTF-8 UTF-8' /etc/locale.gen;" >> $CHROOT_SCRIPT_PATH;
    echo "locale-gen;" >> $CHROOT_SCRIPT_PATH;
    echo "echo LANG=pt_BR.UTF-8 ＞ /etc/locale.conf;" >> $CHROOT_SCRIPT_PATH;
    echo "export LANG=pt_BR.UTF-8;" >> $CHROOT_SCRIPT_PATH;
    echo "ln -s /usr/share/zoneinfo/America/Recife /etc/localtime;" >> $CHROOT_SCRIPT_PATH;
    echo "hwclock --systohc --utc;" >> $CHROOT_SCRIPT_PATH;
    echo "systemctl enable NetworkManager;" >> $CHROOT_SCRIPT_PATH;
    echo "dhcpcd;" >> $CHROOT_SCRIPT_PATH;
    echo "pacman -Syyu;" >> $CHROOT_SCRIPT_PATH;
    echo "touch /etc/vconsole.conf;" >> $CHROOT_SCRIPT_PATH;
    echo "echo 'KEYMAP=br-abnt2' >> /etc/vconsole.conf;" >> $CHROOT_SCRIPT_PATH;
    echo "echo 'FONT=Lat2-Terminus16' >> /etc/vconsole.conf;" >> $CHROOT_SCRIPT_PATH;
    echo "echo 'FONT_MAP=' >> /etc/vconsole.conf;" >> $CHROOT_SCRIPT_PATH;
    echo "hostnamectl set-hostname $HOSTNAME" >> $CHROOT_SCRIPT_PATH;
    echo "echo 'Please define a password for the root user:';" >> $CHROOT_SCRIPT_PATH;
    echo "passwd;" >> $CHROOT_SCRIPT_PATH;
    echo "useradd -m -g users -G wheel,storage,power -s /usr/bin/zsh -d $FINAL_HOME $USERNAME;" >> $CHROOT_SCRIPT_PATH;
    echo "echo 'Please define a password for your user:';" >> $CHROOT_SCRIPT_PATH;
    echo "passwd $USERNAME;" >> $CHROOT_SCRIPT_PATH;
    echo "touch /etc/sudoers.d/wheel" >> $CHROOT_SCRIPT_PATH;
    echo "echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers.d/wheel" >> $CHROOT_SCRIPT_PATH;
    echo "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch" >> $CHROOT_SCRIPT_PATH;
    echo "grub-mkconfig -o /boot/grub/grub.cfg" >> $CHROOT_SCRIPT_PATH;
    echo "" >> $CHROOT_SCRIPT_PATH;
    echo "" >> $CHROOT_SCRIPT_PATH;

    chmod +x $CHROOT_SCRIPT_PATH;
}
