SCRIPT_DIR=`cd \`dirname $0\` && pwd`;
source $SCRIPT_DIR/functions.sh;

PACKAGES=(
    base
    linux-lts
    sudo
    zsh
    grub
    efibootmgr
    os-prober
    dhcpcd
    wireless_tools
    wpa_supplicant
    netcf
    dialog
)

# Install Base System
STEP="Install Packades Step";
stop_if_fail pacstrap /mnt `array_join ${PACKAGES[@]}`;