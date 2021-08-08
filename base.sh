
source ./functions.sh;

BASE_PACKAGES=(
    base
    linux-lts
    linux-firmware
    sudo
    zsh
    grub
    efibootmgr
    os-prober
    nano
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
    xorg-server
    xorg-xinit
    ttf-dejavu
    xorg-xwayland
    pipewire
    pipewire-pulse
    bluez
    bluez-utils
);

OPENBOX_DEV_ENVIRONMENT=(
    lightdm
    accountsservice
    lightdm-gtk-greeter
    openbox
    menumaker
    xterm
);

KDE_PACKAGES=(
    plasma-destop
    phonon-qt5-vlc
    sddm
    plasma-nm
    plasma-pa
    konsole
    plasma-wayland-session
)

PACKAGES=(
    ${BASE_PACKAGES[@]}
    ${NETWORK_PACKAGES[@]}
    ${SYSTEM_UTILS[@]}
);

if [ $ENABLE_OPENBOX ]
then
    PACKAGES+=(
        ${OPENBOX_DEV_ENVIRONMENT[@]}
    );
fi

if [ $VBOX ]
then
    PACKAGES+=(
        virtualbox-guest-utils
    );
fi

# Install Base System
STEP="Install Packages Step";
stop_if_fail pacstrap /mnt ${PACKAGES[@]};