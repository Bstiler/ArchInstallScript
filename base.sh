
source ./functions.sh;

BASE_PACKAGES=(
    base
    base-devel
    linux-lts
    linux-firmware
    sudo
    zsh
    grub
    efibootmgr
    os-prober
    nano
    btrfs-progs
    dosfstools
    man-db
);

NETWORK_PACKAGES=(
    dhcpcd
    wireless_tools
    wpa_supplicant
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
    git
    p7zip
    unrar
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
    plasma-desktop
    phonon-qt5-gstreamer
    discover
    packagekit-qt5
    ark
    sddm
    sddm-kcm
    qt5-translations
    aspell
    aspell-pt
    aspell-en
    plasma-nm
    plasma-pa
    konsole
    plasma-wayland-session
    bluedevil
    powerdevil
    kdeplasma-addons
    khotkeys
    kscreen
    kwrited
    plasma-firewall
)

GNOME_PACKAGES=(
    gnome-shell
    gdm
    tilix
    gnome-control-center
    nautilus
    gnome-shell-extension-appindicator
)

INSTALL_MEDIA_PACKAGES=(
    arch-install-scripts
    reflector
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

if [ $KDE ]
then
    PACKAGES+=(
        ${KDE_PACKAGES[@]}
    );
fi

if [ $GNOME ]
then
    PACKAGES+=(
        ${GNOME_PACKAGES[@]}
    );
fi

if [ $VBOX ]
then
    PACKAGES+=(
        virtualbox-guest-utils
    );
fi

if [ $INSTALL_MEDIA ]
then
    PACKAGES+=(
        ${INSTALL_MEDIA_PACKAGES[@]}
    );
fi

CACHE_PACSTRAP='';

if [ $PACMAN_CACHE ]
then
    CACHE_PACSTRAP='-c';
fi

# Install Base System
STEP="Install Packages Step";
stop_if_fail pacstrap $CACHE_PACSTRAP /mnt ${PACKAGES[@]};
