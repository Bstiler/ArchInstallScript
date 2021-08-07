SCRIPT_DIR=`cd \`dirname $0\` && pwd`;
source $SCRIPT_DIR/functions.sh;

BASE_PACKAGES=(
    base
    linux-lts
    sudo
    zsh
    grub
    efibootmgr
    os-prober
);

NETWORK_PACKAGES=(
    dhcpcd
    wireless_tools
    wpa_supplicant
    netcf
    dialog
    networkmanager
    networkmanager-vpnc
    networkmanager-pptp
    networkmanager-openconnect
    network-manager-applet
);

SYSTEM_UTILS=(
    xdg-utils
);

PACKAGES=(
    ${BASE_PACKAGES[@]}
    ${NETWORK_PACKAGES[@]}
    ${SYSTEM_UTILS[@]}
);

# Install Base System
STEP="Install Packades Step";
stop_if_fail pacstrap /mnt ${PACKAGES[@]};