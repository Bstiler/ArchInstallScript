SCRIPT_DIR=`cd \`dirname $0\` && pwd`;
source $SCRIPT_DIR/functions.sh;

# Install Base System
STEP="Install Packades Step";
stop_if_fail error_tolerant_pacman pacman -Sy;
stop_if_fail error_tolerant_pacstrap pacstrap /mnt;