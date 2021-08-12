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

if [ $ENABLE_OPENBOX -eq 1 ]
then
    enable_openbox;
fi
