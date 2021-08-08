# Create Sub-script


source ./chroot-configs.sh;

generate_chroot_script() {
    if [ ! $1 ]
    then
        export CHROOT_SCRIPT_PATH=/tmp/chroot-script.sh;
    else
        export CHROOT_SCRIPT_PATH=$1;
    fi

    touch $CHROOT_SCRIPT_PATH;

    basic_config $CHROOT_SCRIPT_PATH;
    update_repos $CHROOT_SCRIPT_PATH;
    vconsole_config $CHROOT_SCRIPT_PATH;
    user_config $CHROOT_SCRIPT_PATH;
    sudo_config $CHROOT_SCRIPT_PATH;
    grub_config $CHROOT_SCRIPT_PATH;

    if [ $ENABLE_OPENBOX ]
    then
        enable_openbox $CHROOT_SCRIPT_PATH;
    fi

    chmod +x $CHROOT_SCRIPT_PATH;
}
