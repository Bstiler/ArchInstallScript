#!/bin/sh

cd `dirname $0`;

source ./postinstall-scripts.sh;

basic_config;
update_repos;
vconsole_config;
user_config;
sudo_config;
enable_bluetooth;
grub_config;

if [ $ENABLE_OPENBOX ]
then
    enable_openbox;
fi

if [ $VBOX ]
then
    enable_virtualbox;
fi

if [ $KDE ]
then
    enable_kde;
fi

if [ $INSTALL_MEDIA ]
then
    enable_auto_login;
fi