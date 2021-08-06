#!/bin/sh

SCRIPT_DIR=`cd \`dirname $0\` && pwd`;

# Step 1: Config some misc stuff
echo "Initial Setup Started";
source $SCRIPT_DIR/env-check.sh;
source $SCRIPT_DIR/initial-setup.sh;

# Step 2: Setup Root filesystem
source $SCRIPT_DIR/rootfs.sh;
set_root_as_btrfs $ROOTFS;

# Step 3: Mount partitions
source $SCRIPT_DIR/mount.sh;
mount_stuff;

# Set up home folder
source $SCRIPT_DIR/home.sh;
create_home;

# Install Base System
source $SCRIPT_DIR/base.sh;

# Generate FSTAB
source $SCRIPT_DIR/fstab.sh;
generate_fstab;

# Create Sub-script

source $SCRIPT_DIR/chroot-script-generator.sh
