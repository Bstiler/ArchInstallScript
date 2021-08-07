#!/bin/sh

SCRIPT_DIR=`cd \`dirname $0\` && pwd`;

# Step 1: Config some misc stuff
echo "Initial Setup Started";
source $SCRIPT_DIR/modules/modules/env-check.sh;
source $SCRIPT_DIR/modules/initial-setup.sh;

# Step 2: Setup Root filesystem
source $SCRIPT_DIR/modules/rootfs.sh;
set_root_as_btrfs $ROOTFS;

# Step 3: Mount partitions
source $SCRIPT_DIR/modules/mount.sh;
mount_stuff;

# Set up home folder
source $SCRIPT_DIR/modules/home.sh;
create_home;

# Install Base System
source $SCRIPT_DIR/modules/base.sh;

# Generate FSTAB
source $SCRIPT_DIR/modules/fstab.sh;
generate_fstab;

# Create Sub-script

source $SCRIPT_DIR/modules/chroot-script-generator.sh;
export CHROOT_INTERNAL_PATH=/root/install.sh;

generate_chroot_script;

cp $CHROOT_SCRIPT_PATH "/mnt$CHROOT_INTERNAL_PATH";

arch-chroot /mnt $CHROOT_INTERNAL_PATH;
