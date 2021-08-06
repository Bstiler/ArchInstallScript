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