# Create Sub-script

touch /tmp/chroot-script.sh

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
echo "pacman -S wireless_tools wpa_supplicant wpa_actiond netcf dialog sudo;" >> /tmp/chroot-script.sh;
echo "systemctl enable net-auto-wireless.service;" >> /tmp/chroot-script.sh;
echo "" >> /tmp/chroot-script.sh;
echo "" >> /tmp/chroot-script.sh;
echo "" >> /tmp/chroot-script.sh;

chmod +x /tmp/chroot-script.sh;