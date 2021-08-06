#!/bin/sh
STEP="Setup Step";

source ./.env;

if [ ! $ROOTFS ]
then
echo "Root filesystem partition variable not found, define \$ROOTFS with a valid partition.";
exit;
fi

if [ ! $EFIFS ]
then
echo "EFI filesystem partition variable not found, define \$EFIFS with a valid partition.";
exit;
fi

if [ ! $HOMEFS ]
then
echo "EFI filesystem partition variable not found, define \$EFIFS with a valid partition.";
exit;
fi

if [ ! $USERNAME ]
then
echo "Username variable not found. Please define one at the \$USERNAME variable.";
exit;
fi

if [ ! $MAIN_PASSWORD ]
then
echo "Password variable not found. Please define one at the \$MAIN_PASSWORD variable.";
exit;
fi

stop_if_fail() {
	eval $*;
	if [ ! $? -eq 0 ]
	then
		echo "The $STEP failed.";
		echo "The specific command that failed was: $*";
		exit;
	fi
}

stop_if_previous_failed() {
    if [ ! $? -eq 0 ]
	then
		echo "The $STEP failed.";
		echo "The specific command that failed was: $*";
		exit;
	fi
}

error_tolerant_pacman() {
	eval $*;
	if [ ! $? -eq 0 ]
	then
		rm -rf /var/lib/pacman/sync;
		pacman -Syyu;
		eval $*;
	fi
}

error_tolerant_pacstrap() {
	eval $*;
	if [ ! $? -eq 0 ]
	then
		rm -rf /mnt/var/lib/pacman/sync;
		pacman -Syyu;
		eval $*;
	fi
}

# Check Netowrk
stop_if_fail ping -c 3 1.1.1.1;

# Config the Clock
STEP="Clock Config Step";
timedatectl set-ntp true;

# Set Language
STEP="Language Config Step";
sed -i '#/en_US.UTF-8 UTF-8/c\en_US.UTF-8 UTF-8' /etc/locale.gen;
sed -i '#/pt_BR.UTF-8 UTF-8/c\pt_BR.UTF-8 UTF-8' /etc/locale.gen;
locale-gen;
export LANG=pt_BR.UTF-8;

# Set up Root filesystem
STEP="Set Up Root Filesystem";
stop_if_fail mkfs.btrfs -f $ROOTFS;
stop_if_fail mount $ROOTFS /mnt;
cd /mnt;
stop_if_fail btrfs subvolume create @;
stop_if_fail btrfs subvolume create swap;
cd ~;
stop_if_fail umount /mnt;


# Mount partitions
STEP="Mount Partitions Step";
stop_if_fail mount -o subvol=@ $ROOTFS /mnt;

mkdir -p /mnt/media/$USERNAME/home;
mkdir -p /mnt/boot/efi;
mkdir -p /mnt/opt/swap_partition;

stop_if_fail mount $HOMEFS /mnt/media/$USERNAME/home;
stop_if_fail mount $EFIFS /mnt/boot/efi;
stop_if_fail mount -o subvol=swap $ROOTFS /mnt/opt/swap_partition;

# BTRFS swapfile setup
STEP="BTRFS swapfile Set Up Step";
stop_if_fail cd /mnt/opt/swap_partition;
touch swapfile;
stop_if_fail chmod 600 ./swapfile;
stop_if_fail truncate -s 0 ./swapfile;
stop_if_fail chattr +C ./swapfile;
stop_if_fail btrfs property set ./swapfile compression none;
stop_if_fail dd if=/dev/zero of=$PWD/swapfile bs=1M count=1024 status=progress;
stop_if_fail mkswap ./swapfile;
stop_if_fail swapon ./swapfile;
echo "" >> /etc/fstab;
echo "# Swapfile set up";
echo "$PWD/swapfile	none	swap	defaults	0	0" >> /etc/fstab;

# Set up home folder
STEP="Set Up Home Folder Step";
mkdir /mnt/media/$USERNAME/home/arch;

# Install Base System
STEP="Install Packades Step";
stop_if_fail error_tolerant_pacman pacman -Sy;
stop_if_fail error_tolerant_pacstrap pacstrap /mnt;

# Generate FSTAB
STEP="Generate FSTAB Step";
genfstab -U -p /mnt ＞ /mnt/etc/fstab;
stop_if_previous_failed;
echo "Time to see the fstab";

# Create Sub-script

touch /tmp/chroot-script.sh

echo "#!/bin/sh" >> /tmp/chroot-script.sh;
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
