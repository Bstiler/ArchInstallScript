source ./function.sh;

# BTRFS swapfile setup

# Sets a swapfile for the installation
# Can take a number of megabytes as first parameter
# If no parameter is given 1024 is used
set_up_swapfile() {
    if [ ! $1 ]; then
        SIZE=1024
    else
        SIZE=$1
    fi

    STEP="BTRFS swapfile Set Up Step"
    stop_if_fail cd /mnt/opt/swap_partition
    touch swapfile
    stop_if_fail chmod 600 ./swapfile
    stop_if_fail truncate -s 0 ./swapfile
    stop_if_fail chattr +C ./swapfile
    stop_if_fail btrfs property set ./swapfile compression none
    stop_if_fail dd if=/dev/zero of=$PWD/swapfile bs=1M count=$SIZE status=progress
    stop_if_fail mkswap ./swapfile
    stop_if_fail swapon ./swapfile
    echo "" >>/etc/fstab
    echo "# Swapfile set up"
    echo "$PWD/swapfile	none	swap	defaults	0	0" >> /etc/fstab
}
