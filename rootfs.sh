source ./functions.sh;
# Set up Root filesystem

# Receives the device to be used as root file system
set_root_as_btrfs() {
    if [ ! $1 ]
    then
        echo "You forgot to provide a parameter to the set_root_as_btrfs function.";
        exit;
    fi

    STEP="Set Up Root Filesystem"
    stop_if_fail mkfs.btrfs -f $1
    stop_if_fail mount $1 /mnt
    cd /mnt
    stop_if_fail btrfs subvolume create @
    stop_if_fail btrfs subvolume create swap
    cd ~
    stop_if_fail umount /mnt
}
