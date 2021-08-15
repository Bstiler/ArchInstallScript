
source ./env-check.sh
source ./functions.sh

# Mount partitions
mount_stuff() {
    STEP="Mount Partitions Step"
    stop_if_fail mount -o subvol=@ $ROOTFS /mnt

    mkdir -p /mnt/media/$USERNAME/home
    mkdir -p /mnt/boot/efi

    stop_if_fail mount $HOMEFS /mnt/media/$USERNAME/home
    stop_if_fail mount $EFIFS /mnt/boot/efi

    if [ $INSTALL_MEDIA ]
    then
        mkdir -p /mnt/var/cache/pacman/pkg
        mount $PACMAN_CACHE /mnt/var/cache/pacman/pkg
    fi
}

umount_stuff() {
    umount /mnt/var/cache/pacman/pkg
    umount /mnt/media/$USERNAME/home
    umount /mnt/boot/efi
    umount /mnt
}
