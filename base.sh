SCRIPT_DIR=`cd \`dirname $0\` && pwd`;
source $SCRIPT_DIR/functions.sh;

# Install Base System
STEP="Install Packades Step";
stop_if_fail pacstrap /mnt base sudo zsh grub efibootmgr dhcpcd;