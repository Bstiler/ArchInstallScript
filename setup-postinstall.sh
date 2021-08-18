source ./env-setup.sh;
source ./functions.sh;

setup_global_vars() {
    add_post_install_var HOSTNAME $HOSTNAME;
    add_post_install_var USERNAME $USERNAME;
    add_post_install_var ENABLE_OPENBOX $ENABLE_OPENBOX;
    add_post_install_var INSTALL_NAME $INSTALL_NAME;

    if [ $INSTALL_MEDIA ]
    then
        add_post_install_var INSTALL_MEDIA $INSTALL_MEDIA;
    fi
}

copy_vars_file() {
    cp /tmp/postinstall-vars.sh $1;
}

ignite_postinstall() {
    setup_global_vars;
    copy_vars_file /mnt/root;
    cp ./postinstall-scripts.sh /mnt/root;
    cp ./postinstall.sh /mnt/root;
    cp ./functions.sh /mnt/root;
    chmod +x /mnt/root/postinstall.sh;
    arch-chroot /mnt /root/postinstall.sh;
}