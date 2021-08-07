SCRIPT_DIR=`cd \`dirname $0\` && pwd`;
source $SCRIPT_DIR/env-check.sh
source $SCRIPT_DIR/functions.sh

# Mount partitions
mount_stuff() {
    STEP="Mount Partitions Step"
    stop_if_fail mount -o subvol=@ $ROOTFS /mnt

    mkdir -p /mnt/media/$USERNAME/home
    mkdir -p /mnt/boot/efi

    stop_if_fail mount $HOMEFS /mnt/media/$USERNAME/home
    stop_if_fail mount $EFIFS /mnt/boot/efi
}

umount_stuff() {
    umount /mnt/media/$USERNAME/home
    umount /mnt/boot/efi
    umount /mnt
}
