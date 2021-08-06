source ./env-check.sh;
source ./functions.sh;

# Mount partitions
STEP="Mount Partitions Step";
stop_if_fail mount -o subvol=@ $ROOTFS /mnt;

mkdir -p /mnt/media/$USERNAME/home;
mkdir -p /mnt/boot/efi;
mkdir -p /mnt/opt/swap_partition;

stop_if_fail mount $HOMEFS /mnt/media/$USERNAME/home;
stop_if_fail mount $EFIFS /mnt/boot/efi;
stop_if_fail mount -o subvol=swap $ROOTFS /mnt/opt/swap_partition;
